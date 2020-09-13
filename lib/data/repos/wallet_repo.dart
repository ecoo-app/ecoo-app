import 'dart:async';

import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/config.generated.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';

import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:e_coupon/injection.dart';

import 'package:ecoupon_lib/common/errors.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/paper_wallet.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:ecoupon_lib/models/wallet_migration.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

import '../network_info.dart';

@prodEnv
@devEnv
@LazySingleton(as: IWalletRepo)
// @lazySingleton
class WalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  final INetworkInfo networkInfo;
  final IWalletSource walletSource;

  WalletRepo({this.localDataSource, this.networkInfo, this.walletSource});

  @override
  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false}) async {
    Either<Failure, Wallet> result;

    if (await networkInfo.isConnected) {
      try {
        if (currency == null) {
          var currencies = await walletSource.walletService.fetchCurrencies();
          currency = currencies.items[0];
        }
        final wallet = await walletSource.walletService
            .createWallet(currency, isCompany: isShop);
        result = Right(wallet);
      } on NotAuthenticatedError {
        result = Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        result = Left(HTTPFailure.from(e));
      } on PlatformException catch (e) {
        if (e.code == '-5') {
          result = Left(NoPinSetFailure());
        }
      } catch (anyerror) {
        print('error $anyerror');
        // TODO log/send error
        result = Left(UnknownFailure());
      }
    } else {
      result = Left(NoService());
    }

    return result;
  }

  @override
  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor) async {
    Either<Failure, ListResponse<Transaction>> result;

    if (await networkInfo.isConnected) {
      try {
        var transactions = await walletSource.walletService
            .fetchTransactions(walletID: id, pageSize: 100);
        result = Right(transactions);
        //
      } on NotAuthenticatedError {
        result = Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        result = Left(HTTPFailure.from(e));
      }
    } else {
      result = Left(NoService());
    }

    return result;
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        final wallets = await walletSource.walletService.fetchWallets();
        final walletEntities =
            wallets.items.map((wallet) => WalletEntity(wallet)).toList();
        await localDataSource.cacheWallets(walletsKey, walletEntities);
        return Right(walletEntities);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      try {
        final wallets = await localDataSource.getWallets(walletsKey);
        return Right(wallets);
      } catch (e) {
        // type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'FutureOr<List<WalletEntity>>'
        //CacheException
        print('$e');
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWalletData(String walletID) async {
    if (await networkInfo.isConnected) {
      try {
        final wallet = await walletSource.walletService.fetchWallet(walletID);
        final walletEntity = WalletEntity(wallet);
        unawaited(localDataSource.cacheWallet(singleWalletKey, walletEntity));
        return Right(walletEntity);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        if (e.statusCode == 404) {
          var walletsOrFailure = await getWallets('');
          Either<Failure, WalletEntity> result;
          walletsOrFailure.fold((failure) => result = Left(failure),
              (wallets) => result = Right(wallets.first));
          return result;
        }
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      try {
        final wallet = await localDataSource.getWallet(singleWalletKey);
        return Right(wallet);
      } catch (e) {
        print('$e');
        //CacheException
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount) async {
    if (await networkInfo.isConnected) {
      Wallet senderModel = sender.walletModel;
      try {
        if (!(await walletSource.walletService
            .canSignWithWallet(senderModel))) {
          return Left(NoTransactionPossibleFailure());
        }
        final transaction = await walletSource.walletService
            .transfer(senderModel, reciever.walletModel, amount);
        return Right(transaction);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        print(e);
        // return Left(MessageFailure(e.toString()));
        return Left(UnknownFailure());
      }
    } else {
      return Left(NoService());
    }
  }

  @override
  Future<Either<Failure, Transaction>> handlePaperTransfer(
      PaperWallet source, WalletEntity destination, int amount) async {
    if (await networkInfo.isConnected) {
      try {
        final transaction = await walletSource.walletService.paperTransfer(
          source,
          destination.walletModel,
          amount,
          Config.paperwallet_decryption_key,
        );
        return Right(transaction);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        // return Left(MessageFailure(e.toString()));
        return Left(UnknownFailure());
      }
    } else {
      return Left(NoService());
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> createProfile(
      WalletEntity walletEntity, ProfileEntity profile) async {
    if (await networkInfo.isConnected) {
      try {
        if (profile is UserProfileEntity) {
          var backendUser = await walletSource.walletService.createUserProfile(
            walletEntity.walletModel,
            profile.firstName,
            profile.lastName,
            profile.phoneNumber,
            profile.dateOfBirth,
            profile.addressStreet,
            profile.addressTown,
            profile.postcode,
            profile.placeOfOrigin,
          );
          if (backendUser != null) {
            return Right(UserProfileEntity.from(backendUser));
          }
        }
        if (profile is CompanyProfileEntity) {
          var backendCompany = await walletSource.walletService
              .createCompanyProfile(
                  walletEntity.walletModel,
                  profile.name,
                  profile.uid,
                  profile.addressStreet,
                  profile.addressTown,
                  profile.addressPostalCode,
                  profile.phoneNumber);
          if (backendCompany != null) {
            return Right(CompanyProfileEntity.from(backendCompany));
          }
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }
    return Left(NoService());
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> profiles(bool isCompany,
      {String forWalletId}) async {
    if (await networkInfo.isConnected) {
      try {
        List<ProfileEntity> profileList;

        if (isCompany) {
          profileList = await _fetchCompanyProfiles(forWalletId: forWalletId);
        } else {
          profileList = await _fetchUserProfiles(forWalletId: forWalletId);
        }

        if (profileList.isNotEmpty) {
          return Right(profileList);
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }
    return Right(<ProfileEntity>[]);
  }

  Future<List<ProfileEntity>> _fetchUserProfiles({String forWalletId}) async {
    // TODO fetch all!
    var backendProfiles =
        await walletSource.walletService.fetchUserProfiles(pageSize: 100);
    if (backendProfiles.items.isNotEmpty) {
      var profileList = <ProfileEntity>[];
      for (final backendProfile in backendProfiles.items) {
        if (forWalletId != null) {
          if (forWalletId == backendProfile.walletID) {
            profileList.add(UserProfileEntity.from(backendProfile));
          }
        } else {
          profileList.add(UserProfileEntity.from(backendProfile));
        }
      }

      return profileList;
    }
    return [];
    // var backendProfiles = await walletSource.walletService.fetchUserProfiles();
    // if (backendProfiles.items.isNotEmpty) {
    //   var profileList = <ProfileEntity>[];
    //   for (final backendProfile in backendProfiles.items) {
    //     profileList.add(UserProfileEntity.from(backendProfile));
    //   }
    //   return profileList;
    // }
  }

  Future<List<ProfileEntity>> _fetchCompanyProfiles(
      {String forWalletId}) async {
    // TODO fetch all!
    var backendProfiles =
        await walletSource.walletService.fetchCompanyProfiles(pageSize: 100);
    if (backendProfiles.items.isNotEmpty) {
      var profileList = <ProfileEntity>[];
      for (final backendProfile in backendProfiles.items) {
        if (forWalletId != null) {
          if (forWalletId == backendProfile.walletID) {
            profileList.add(CompanyProfileEntity.from(backendProfile));
          }
        } else {
          profileList.add(CompanyProfileEntity.from(backendProfile));
        }
      }

      return profileList;
    }
    return [];
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> companyProfiles(
      {String walletId}) async {
    if (await networkInfo.isConnected) {
      try {
        var backendProfiles =
            await walletSource.walletService.fetchCompanyProfiles();
        if (backendProfiles.items.isNotEmpty) {
          var profileList = <ProfileEntity>[];
          for (final backendProfile in backendProfiles.items) {
            if (walletId != null) {
              if (walletId == backendProfile.walletID) {
                profileList.add(CompanyProfileEntity.from(backendProfile));
              }
            } else {
              profileList.add(CompanyProfileEntity.from(backendProfile));
            }
          }

          return Right(profileList);
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }
    return Right(<ProfileEntity>[]);
  }

  @override
  Future<Either<Failure, bool>> verify(
      ProfileEntity profileEntity, String pin) async {
    if (await networkInfo.isConnected) {
      try {
        if (profileEntity is UserProfileEntity) {
          await walletSource.walletService
              .verifyUser(profileEntity.toLibProfile(), pin);
          return Right(true);
        }
        if (profileEntity is CompanyProfileEntity) {
          await walletSource.walletService
              .verifyCompany(profileEntity.toLibProfile(), pin);
          return Right(true);
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }

    return Right(false);
  }

  @override
  Future<Either<Failure, List<WalletMigration>>>
      fetchAllWalletMigrations() async {
    if (await networkInfo.isConnected) {
      try {
        // TODO use pagination
        final fetchedMigrations = await walletSource.walletService
            .fetchWalletMigrations(pageSize: 100);

        if (fetchedMigrations != null) {
          return Right(fetchedMigrations.items);
        } else {
          return Left(UnknownFailure());
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(NoService());
    }
  }

  @override
  Future<Either<Failure, List<WalletMigration>>>
      fetchAllWalletMigrationsForWallet(String walletID) async {
    Either<Failure, List<WalletMigration>> result;

    var migrationsOrFailure = await fetchAllWalletMigrations();

    migrationsOrFailure.fold(
        (failure) => result = Left(failure),
        (migrations) => result = Right(migrations
            .where((migration) => migration.walletID == walletID)
            .toList()));

    return result;
  }

  @override
  Future<Either<Failure, WalletMigration>> migrateWallet(
      WalletEntity wallet) async {
    if (await networkInfo.isConnected) {
      try {
        var migration =
            await walletSource.walletService.migrateWallet(wallet.walletModel);

        if (migration != null) {
          return Right(migration);
        } else {
          return Left(UnknownFailure());
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }
    return Left(NoService());
  }

  @override
  Future<Either<Failure, bool>> walletCanSign(WalletEntity wallet) async {
    if (await networkInfo.isConnected) {
      try {
        var canSign = await walletSource.walletService
            .canSignWithWallet(wallet.walletModel);

        if (canSign != null) {
          return Right(canSign);
        } else {
          return Left(UnknownFailure());
        }
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure.from(e));
      } catch (e) {
        return Left(UnknownFailure());
      }
    }
    return Left(NoService());
  }
}
