import 'package:flutter/material.dart';
import 'package:planning_App/widgets/chart_bar.dart';
import '../models/transaction.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recientTransactions;

  Chart(this.recientTransactions);

  List<Map<String, Object>> get groupedTransactionsValued {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recientTransactions.length; i++) {
        if (recientTransactions[i].date.day == weekDay.day &&
            recientTransactions[i].date.month == weekDay.month &&
            recientTransactions[i].date.year == weekDay.year) {
          totalSum += recientTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalspending {
    return groupedTransactionsValued.fold(0.0, (start, item) {
        return start + item['amount'] ; 
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValued);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValued.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalspending == 0.0 ? 0.0 : ( data['amount'] as double)  / totalspending
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
