import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  addTrans() {
    final text = titleController.text;
    final amount = double.parse(amountController.text);

    if ( text.isEmpty || amount <= 0 ){
      return;
    }
    widget.addTx( text , amount );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) =>  addTrans(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>  addTrans(),
            ),
            FlatButton(
              // color: Colors.tealAccent[700],
              color: Theme.of(context).accentColor,
              child: Text(
                "Add Transaction",
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 17,
                ),
              ),
              onPressed:  addTrans,
              splashColor: Colors.pink[300],
            ),
          ],
        ),
      ),
    );
  }
}
