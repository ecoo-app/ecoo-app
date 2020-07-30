import 'package:e_coupon/business/entities/transaction.dart';
import 'package:injectable/injectable.dart';

abstract class ITransferService {
  void setTransaction(Transfer transfer);
  void reset();
  Transfer get transfer;
}

@LazySingleton(as: ITransferService)
class TransferService extends ITransferService {
  Transfer _transfer;
  @override
  void setTransaction(Transfer transfer) {
    this._transfer = transfer;
  }

  @override
  Transfer get transfer => this._transfer;

  @override
  void reset() {
    this._transfer = Transfer();
  }
}
