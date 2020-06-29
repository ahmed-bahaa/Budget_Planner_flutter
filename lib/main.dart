import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]);
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

  bool _showChart = false ;

  List<Transaction> get _recientTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter((DateTime.now().subtract(
        Duration(days: 7),
      )));
    }).toList();
  }

  _addTransaction(String txTitle, double txamount, DateTime chosendate) {
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

  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((Tx) => Tx.id == id);
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
    
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape ;
    final appbar = AppBar(
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
    );
    final listWidget = Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .55, //50
              child: TransactionList(_userTransactions, _deleteTransaction),
            );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                if ( isLandscape ) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show chart"),
                    Switch(value: _showChart, onChanged: (val) {
                      setState(() {
                        _showChart = val ;
                      });
                      
                    }),
                  ],
                ),
                if ( !isLandscape ) Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      .1, //50
                  width: 400,
                  child: Image.asset(
                    'assets/images/bottom.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            if ( !isLandscape ) listWidget,
            if ( isLandscape ) _showChart ?
            Container(
              child: Chart(_recientTransactions),
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .25,
            ) : 
            listWidget,
            if ( !isLandscape ) Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      .1, //50
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
