import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Colors.cyan[300],
          accentColor: Colors.lime[300],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
      title: "Flutter APP",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Adidas',
    //   amount: 600,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Nike',
    //   amount: 500.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Tshirts',
    //   amount: 4500,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recientTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter((DateTime.now().subtract(
        Duration(days: 7),
      )));
    }).toList();
  }

  _addTransaction(String txTitle, double txamount , DateTime chosendate) {
    final newtx = Transaction(
      amount: txamount,
      title: txTitle,
      date: chosendate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newtx);
    });
  }

  void _startNewTrnas(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Budget Planner",
          // style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTrnas(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 400,
                  child: Image.asset(
                    'assets/images/bottom.png',
                    fit: BoxFit.cover,
                    
                  ),
                )
              ],
            ),
            Chart(_recientTransactions),
            Container(
              height: 350,
              child: TransactionList(_userTransactions),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 400,
                  child: Image.asset(
                    'assets/images/bottom.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.tealAccent[700],
        splashColor: Colors.tealAccent,
        child: Icon(Icons.add),
        onPressed: () => _startNewTrnas(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
