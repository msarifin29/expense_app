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
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
                fontFamily: 'Quicksand', fontSize: 13, color: Colors.grey),
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
  bool _showChart = false;
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addNewTransaction(String newTitle, double newAmount, DateTime chosenDate) {
    final addTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: chosenDate);
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

  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text(
        'Personal Expense',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      centerTitle: true,
    );

    final txListWidget = SizedBox(
      height:
          (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
              0.7,
      child: ListTransaction(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('show chart'),
                Switch(
                  value: true,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransaction: _recentTransaction)),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7)
                : txListWidget,
        ],
      )),
      floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          child: const Icon(Icons.add),
          onPressed: () => _startNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
