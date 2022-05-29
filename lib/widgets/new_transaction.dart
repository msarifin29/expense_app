import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addNewTx}) : super(key: key);
  final Function addNewTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectDateTime;

  void addNewTransaction() {
    if (amountController.text.isEmpty) {
      return;
    }
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);
    // ignore: unrelated_type_equality_checks
    if (inputTitle.isEmpty || inputAmount.toString().isEmpty) {
      return;
    }
    widget.addNewTx(inputTitle, inputAmount, _selectDateTime);
    Navigator.pop(context);
  }

  void _showDateTime() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDateTime = pickedDate;
      });
    });
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
            decoration: const InputDecoration(label: Text('Amount')),
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => addNewTransaction),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectDateTime == null
                  ? 'No Data Chosen !'
                  : 'Picked Date : ${DateFormat.yMEd().format(_selectDateTime!)}'),
              TextButton(
                onPressed: _showDateTime,
                child: const Text(
                  'Chosen Date',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: addNewTransaction,
            child: const Text(
              'Add Transaction',
            )),
      ]),
    );
  }
}
