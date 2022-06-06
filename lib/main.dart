import 'dart:io';

import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';

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
    return Platform.isIOS
        ? const CupertinoApp(
            theme: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                    tabLabelTextStyle: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    navActionTextStyle: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 13,
                        color: Colors.grey),
                    navLargeTitleTextStyle: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                primaryColor: Colors.grey,
                primaryContrastingColor: Colors.amber),
            home: ExpenseApp(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: const TextTheme(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  subtitle1: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 13,
                      color: Colors.grey),
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
    final mediQuery = MediaQuery.of(context);
    final isLandscape = mediQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: const Text(
          'Personal Expense',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        trailing: Row(
          children: [
            GestureDetector(
              onTap: () => _startNewTransaction(context),
              child: const Icon(CupertinoIcons.add),
            )
          ],
        ),
      );
    } else {
      appBar = AppBar(
        title: const Text(
          'Personal Expense',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
          )
        ],
      );
    }

    final txListWidget = SizedBox(
      height: (mediQuery.size.height - appBar.preferredSize.height) * 0.7,
      child: ListTransaction(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );

    final pageBody = SingleChildScrollView(
        child: Column(
      children: [
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('show chart'),
              Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.secondary,
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
              height: (mediQuery.size.height -
                      appBar.preferredSize.height -
                      mediQuery.padding.top) *
                  0.3,
              child: Chart(recentTransaction: _recentTransaction)),
        if (!isLandscape) txListWidget,
        if (isLandscape)
          _showChart
              ? SizedBox(
                  height: (mediQuery.size.height -
                          appBar.preferredSize.height -
                          mediQuery.padding.top) *
                      0.7)
              : txListWidget,
      ],
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    enableFeedback: true,
                    child: const Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
