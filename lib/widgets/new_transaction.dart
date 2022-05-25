import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({Key? key, required this.addNewTx}) : super(key: key);
  final Function addNewTx;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: InputDecoration(label: Text('Title')),
          controller: titleController,
        ),
        TextField(
          decoration: InputDecoration(label: Text('Amount')),
          controller: amountController,
        ),
        TextButton(
            onPressed: () => addNewTx(
                titleController.text, double.parse(amountController.text)),
            child: Text('Add Transaction'))
      ]),
    );
  }
}
