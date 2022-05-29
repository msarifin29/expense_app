import 'package:expense_app/widgets/chart.dart';
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
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 13,
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Colors.amber)),
      home: const ExpenseApp(),
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
    // Transaction(
    //     id: 't1', title: 'New shoes', amount: 20.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'sweater', amount: 16.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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
        title: const Text(
          'Personal Expense',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        centerTitle: true,
      ),
      body: _userTransactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/z.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text('No Transaction')
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Chart(recentTransaction: _recentTransaction),
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
