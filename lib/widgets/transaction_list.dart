import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text("No transactions added yet!",
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/images/tenor.gif',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            // color: Colors.cyan,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            // color: Colors.cyan,
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.title,
                              // style: TextStyle(
                              //   fontWeight: FontWeight.w700,
                              //   fontSize: 18,
                              // ),
                            ),
                            // padding: EdgeInsets.all(5),
                          ),
                          Container(
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(transactions[index].date),
                              style: TextStyle(
                                // fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.blueGrey,
                              ),
                            ),
                            // padding: EdgeInsets.all(5),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
