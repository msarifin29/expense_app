import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);

  final List<Transaction> recentTransaction;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues
            .map((data) => Flexible(
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ChartBar(
                      label: '${data['day']}',
                      spendingAmount: (data['amount'] as double),
                      totalSpendingAmount: totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending),
                )))
            .toList(),
      ),
    );
  }
}
