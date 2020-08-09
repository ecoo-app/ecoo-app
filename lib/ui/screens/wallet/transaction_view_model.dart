// import 'package:injectable/injectable.dart';

// import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
// import 'package:e_coupon/ui/core/base_view/viewstate.dart';
// import 'package:e_coupon/ui/core/services/wallet_service.dart';
// import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';
// import 'package:ecoupon_lib/models/transaction.dart';
// import 'package:ecoupon_lib/models/transaction_list_response.dart';

// @injectable
// class TransactionsViewModel extends BaseViewModel {
//   final IWalletService _walletService;

//   TransactionListCursor _transactionListCursor;
//   Transactions _transactions = Transactions();

//   TransactionsViewModel(this._walletService);

//   Future<void> loadTransactions() async {
//     await _loadTransactions(null);
//   }

//   Future<void> loadMore() async {
//     await _loadTransactions(_transactionListCursor);
//   }

//   Future<void> _loadTransactions(TransactionListCursor cursor) async {
//     var transactionsOrFailure =
//         await _walletService.fetchAndUpdateSelectedTransactions(cursor);

//     transactionsOrFailure.fold((failure) {
//       setViewState(Error(failure));
//     }, (transactionResponse) {
//       setViewState(Loaded());

//       _transactionListCursor = transactionResponse.cursor;
//       transactionResponse.transactions
//           .map((transaction) => _transactions.addTransaction(transaction));
//     });
//   }
// }

// class Transactions {
//   List<TransactionListEntry> items = [];

//   void addTransaction(Transaction transaction) {
// print('try to add ${transaction.from}');
// items.forEach((element) {
//   if (element.date.isSameDate(transaction.created)) {
//     print('add to existing');
//     element.entries.add(TransactionListEntry(
//       transaction.created,
//       transaction.from,
//       Utils.moneyToString(transaction.amount),
//     ));
//     element.entries.sort((a, b) => a.created.compareTo(b.created));
//     return;
//   }
// });
// print('add new');
// items.add(TransactionListDay(transaction.created, [
//   TransactionListEntry(
//     transaction.created,
//     transaction.from,
//     Utils.moneyToString(transaction.amount),
//   )
// ]));
//   }
// }
