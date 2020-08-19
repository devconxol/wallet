import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/services/database.dart';
import 'package:wallet/shared/constants.dart';

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date;
  final _dateController = TextEditingController();
  String date;
  String bank;
  String operationType; // depot ou credit
  double amount;
  String operationPartner;
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
    DatabaseService database = DatabaseService();
    return Form(
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          Text(
            "Ajouter une recette",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _dateController,
            decoration: textInputDecoration.copyWith(hintText: 'Date'),
            validator: (value) => value.isEmpty ? 'Please enter a date' : null,
            onChanged: (value) {
              _dateController.text = value;
              setState(() => date = value);
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
                  _dateController.text = value.toIso8601String();
                  _date = value;
                });
              },
              icon: Icon(Icons.timer),
              label: _date == null
                  ? Text('Choisir une date')
                  : Text(_date.toIso8601String())),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Category'),
            validator: (value) => value.isEmpty ? 'Please enter a bank' : null,
            onChanged: (value) {
              setState(() => operationPartner = value);
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: textInputDecoration.copyWith(hintText: 'Montant'),
            validator: (value) => value.isEmpty ? 'Please enter a bank' : null,
            onChanged: (value) {
              setState(() => amount = double.parse(value));
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
              print('date');
              print(_dateController.text);
              // database.addTransaction(
              //     date, bank, operationType, operationPartner, amount);
            },
          )
        ],
      ),
    );
  }
}
