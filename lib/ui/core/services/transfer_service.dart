import 'package:e_coupon/business/entities/transaction.dart';
import 'package:injectable/injectable.dart';

abstract class ITransferService {
  void setTransaction(Transfer transfer);
}

@LazySingleton(as: ITransferService)
class TransferService extends ITransferService {
  Transfer transfer;
  @override
  void setTransaction(Transfer transfer) {
    this.transfer = transfer;
  }
}
