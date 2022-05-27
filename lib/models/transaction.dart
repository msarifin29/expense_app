class Transaction {
  String id;
  String title;
  double amount = 0;
  DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
