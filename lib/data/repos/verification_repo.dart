import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:ecoupon_lib/models/address_auto_completion_result.dart';
import 'package:injectable/injectable.dart';

abstract class IVerificationRepo {
  Future<Either<Failure, List<AddressAutoCompletionResult>>>
      fetchAutoCompletions(
          {AddressAutoCompletionTarget target, String partialAddress});
}

@LazySingleton(as: IVerificationRepo)
class VerificationRepo extends IVerificationRepo {
  final INetworkInfo _networkInfo;
  final IWalletSource _walletSource;

  VerificationRepo(this._networkInfo, this._walletSource);

  @override
  Future<Either<Failure, List<AddressAutoCompletionResult>>>
      fetchAutoCompletions(
          {AddressAutoCompletionTarget target, String partialAddress}) async {
    if (!await _networkInfo.isConnected) {
      return Left(NoServiceFailure());
    }

    try {
      List<AddressAutoCompletionResult> result = [];

      var addressListResponse = await _walletSource.walletService
          .fetchAutoCompletions(target: target, partialAddress: partialAddress);

      if (addressListResponse != null) {
        result.addAll(addressListResponse.items);

        while (addressListResponse.cursor.next != null) {
          addressListResponse = await _walletSource.walletService
              .fetchAutoCompletions(
                  target: target,
                  partialAddress: partialAddress,
                  cursor: addressListResponse.cursor);
          result.addAll(addressListResponse.items);
        }
      }

      if (result != null) {
        return Right(result);
      }
      return Left(UnknownFailure());
    } catch (e) {
      print(e);
      return Left(UnknownFailure());
    }
  }
}
