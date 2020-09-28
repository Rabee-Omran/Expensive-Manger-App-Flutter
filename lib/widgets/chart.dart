import 'package:expensive_app/model/transaction.dart';
import 'package:expensive_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(totalSpending);
    return 
       Card(
        
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
                child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                          child: ChartBar(
                    e['day'], e['amount'], 
                    totalSpending == 0.0 ?0.0:((e['amount'] as double) / totalSpending)),
              );
            }).toList(),
          ),
        ),
      
    );
  }
}
