import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addNewTx}) : super(key: key);
  final Function addNewTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void addNewTransaction() {
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);
    // ignore: unrelated_type_equality_checks
    if (inputTitle.isEmpty || inputAmount.toString().isEmpty) {
      return;
    }
    widget.addNewTx(inputTitle, inputAmount);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: const InputDecoration(label: Text('Title')),
          keyboardType: TextInputType.text,
          controller: titleController,
          onSubmitted: (_) => addNewTransaction,
        ),
        TextField(
            decoration: InputDecoration(label: Text('Amount')),
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => addNewTransaction),
        TextButton(onPressed: addNewTransaction, child: Text('Add Transaction'))
      ]),
    );
  }
}
