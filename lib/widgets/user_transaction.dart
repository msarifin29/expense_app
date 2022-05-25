import 'package:expense_app/widgets/list_transaction.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New shoes', amount: 20.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'sweater', amount: 16.99, date: DateTime.now()),
  ];

  _addNewTransaction(
    String newTitle,
    double newAmount,
  ) {
    final addTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(addTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTx: _addNewTransaction),
        ListTransaction(transactions: _userTransactions)
      ],
    );
  }
}
