import 'package:expense_app/widgets/new_transaction.dart';

import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/list_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExpenseApp(),
    );
  }
}

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
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

  _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (_) => NewTransaction(
              addNewTx: _addNewTransaction,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Card(
          elevation: 10,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              width: double.infinity,
              child: const Text('Expense')),
        ),
        ListTransaction(transactions: _userTransactions)
      ])),
      floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          child: const Icon(Icons.add),
          onPressed: () => _startNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
