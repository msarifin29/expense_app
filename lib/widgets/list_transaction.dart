import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction(
      {Key? key, required this.transactions, required this.deleteTx})
      : super(key: key);
  final List<Transaction> transactions;
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'No Transaction',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/z.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
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
                            style: Theme.of(context).textTheme.subtitle1),
                        trailing: IconButton(
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            )),
                      ),
                    )));
  }
}
