import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/mock_implementations.dart';

void main() {
  IRouter _router;
  IWalletRepo _walletRepo;
  IWalletService _walletService;
  INetworkInfo _networkInfo;

  WalletViewModel _viewModel;

  setUp(() {
    _router = RouterMock();
    _walletRepo = WalletRepositoryMock();
    _walletService = WalletServiceMock();
    _networkInfo = NetworkInfoMock();

    _viewModel = WalletViewModel(
      _router,
      _walletService,
      _networkInfo,
      _walletRepo,
    );

    when(_walletService.walletsStream)
        .thenAnswer((realIInvocation) => Stream.empty());

    when(_walletService.walletStream)
        .thenAnswer((realIInvocation) => Stream.empty());
  });

  test('transform transaction list into buckets of same dates', () async {
    var transactions = MockTransactionWalletPrivate;
    when(_walletService.fetchAndUpdateSelectedTransactions(any)).thenAnswer(
        (realInvocation) => Future.value(
            Right(ListResponse(transactions, ListCursor('', '')))));
    when(_walletService.getSelected())
        .thenReturn(WalletEntity(privateWalletMock));

    await _viewModel.init();

    _viewModel.transactionStream.listen((event) {
      expect(event.whereType<TransactionListHeaderEntry>().length, 3);
      expect(event.whereType<TransactionListItemEntry>().length, 5);
    });

    await _viewModel.loadTransactions();
  });

  test('transform returns null if no transactions are found', () async {
    when(_walletService.fetchAndUpdateSelectedTransactions(any)).thenAnswer(
        (realInvocation) =>
            Future.value(Right(ListResponse([], ListCursor('', '')))));
    when(_walletService.getSelected())
        .thenReturn(WalletEntity(privateWalletMock));

    await _viewModel.init();

    _viewModel.transactionStream.listen((event) {
      expect(event, []);
    });

    await _viewModel.loadTransactions();
  });
}
