class Wallet {
  final id;
  final amount;
  final currency;
  final isShop;
  final transactions;

  Wallet(
      {this.id,
      this.amount,
      this.currency,
      this.isShop = false,
      this.transactions});
}
