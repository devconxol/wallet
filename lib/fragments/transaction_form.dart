import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/Account.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/shared/constants.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final String title;
  final String uid;
  final List<UserTransaction> transactions;

  TransactionForm({this.uid, this.title, this.transactions});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date;
  final _dateController = TextEditingController();
  String date;
  String category; //
  int amount;
  _printLatestValue() {
    print("Second text field: ${_dateController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _dateController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService database = DatabaseService(uid: widget.uid);
    return Form(
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _dateController,
            decoration: textInputDecoration.copyWith(hintText: 'Date'),
            validator: (value) => value.isEmpty ? 'Please enter a date' : null,
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
          ),
          SizedBox(height: 20.0),
          RaisedButton.icon(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: _date == null ? DateTime.now() : _date,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2222))
                    .then((value) {
                  _dateController.text = DateFormat('dd-MM-yyyy').format(value);
                  _date = value;
                  date = value.toIso8601String();
                });
              },
              icon: Icon(Icons.timer),
              label: Text('Choisir une date')),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Category'),
            validator: (value) => value.isEmpty ? 'Please enter a bank' : null,
            onChanged: (value) {
              setState(() => category = value);
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: textInputDecoration.copyWith(hintText: 'Montant'),
            validator: (value) => value.isEmpty ? 'Please enter a bank' : null,
            onChanged: (value) {
              setState(() => amount = int.parse(value));
            },
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Enrégister',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(date);
              print(category);
              print(amount);

              widget.transactions.add(UserTransaction(
                  date: date,
                  transactionType: "dépense",
                  amount: amount,
                  category: category));

              database.addUserTransaction(widget.transactions);
            },
          )
        ],
      ),
    );
  }
}
