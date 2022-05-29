import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction({Key? key, required this.transactions})
      : super(key: key);
  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) => Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          DateFormat('yyyy-MM-dd')
                              .format(transactions[index].date),
                          style: Theme.of(context).textTheme.subtitle1)),
                )));
  }
}
