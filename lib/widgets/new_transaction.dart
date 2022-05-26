import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({Key? key, required this.addNewTx}) : super(key: key);
  final Function addNewTx;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  void addNewTransaction() {
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0) {
      return;
    }
    addNewTx(inputTitle, inputAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: InputDecoration(label: Text('Title')),
          keyboardType: TextInputType.text,
          controller: titleController,
          onSubmitted: (val) => addNewTransaction,
        ),
        TextField(
          decoration: InputDecoration(label: Text('Amount')),
          keyboardType: TextInputType.number,
          controller: amountController,
          onSubmitted: (val) => addNewTransaction,
        ),
        TextButton(onPressed: addNewTransaction, child: Text('Add Transaction'))
      ]),
    );
  }
}
