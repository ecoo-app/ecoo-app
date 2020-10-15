import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/paper_wallet.dart';
import 'package:ecoupon_lib/models/transaction.dart';

import 'package:ecoupon_lib/models/wallet.dart';
import 'package:ecoupon_lib/models/wallet_migration.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<IWalletEntity>>> getWallets(
      String userIdentifier);

  Future<Either<Failure, IWalletEntity>> getWalletData(String id);

  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor);

  Future<Either<Failure, Transaction>> handleTransaction(
      IWalletEntity sender, IWalletEntity reciever, int amount);

  Future<Either<Failure, Transaction>> handlePaperTransfer(
      PaperWallet source, IWalletEntity destination, int amount);

  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false});

  Future<Either<Failure, bool>> verify(ProfileEntity profileEntity, String pin);

  Future<Either<Failure, ProfileEntity>> createProfile(
      IWalletEntity walletEntity, ProfileEntity profile);

  Future<Either<Failure, List<ProfileEntity>>> profiles(bool isCompany,
      {String forWalletId});

  Future<Either<Failure, List<ProfileEntity>>> companyProfiles(
      {String walletId});

  Future<Either<Failure, List<WalletMigration>>> fetchAllWalletMigrations();

  Future<Either<Failure, List<WalletMigration>>>
      fetchAllWalletMigrationsForWallet(String walletID);

  Future<Either<Failure, WalletMigration>> migrateWallet(IWalletEntity wallet);

  Future<Either<Failure, bool>> walletCanSign(IWalletEntity wallet);
}
