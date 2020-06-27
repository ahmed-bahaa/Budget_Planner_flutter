import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.orange,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
    Transaction(
      id: 't1',
      title: 'Adidas',
      amount: 600,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Nike',
      amount: 500.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Tshirts',
      amount: 4500,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String txTitle, double txamount) {
    final newtx = Transaction(
      amount: txamount,
      title: txTitle,
      date: DateTime.now(),
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
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                // color: Colors.lightBlueAccent,
                color: Theme.of(context).primaryColor,
                child: Text("CHART!"),
              ),
            ),
            TransactionList(_userTransactions),
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
