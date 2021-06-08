import 'package:expense_app/chart_bar.dart';
import 'package:expense_app/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      // Jiffy(weekDay).subtract(months: 1);
      var total = 0.0;
      print(recentTransactions);
      for (var i = 0; i < recentTransactions.length; i++) {
        print(recentTransactions[i].date);
        if (recentTransactions[i].date.weekday == weekDay.weekday) {
          total = total + recentTransactions[i].amount;
          print(total);
        }
      }

      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'Amount': total
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + item['Amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValue);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 4, color: Colors.blue[800])),
      margin: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red[100],
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['Day'],
                sAmount: data['Amount'],
                pctTotal: totalSpend == 0.0
                    ? 0.0
                    : (data['Amount'] as double) / totalSpend,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
