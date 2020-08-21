import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/models/services/database.dart'; 
import 'package:wallet/shared/constants.dart';

class TForm extends StatefulWidget {
  @override
  _TFormState createState() => _TFormState();
}

class _TFormState extends State<TForm> {
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
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Wrap(
              children: <Widget>[
                Text(
                  "Ajouter une nouvelle transaction",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _dateController,
                  decoration: textInputDecoration.copyWith(hintText: 'Date'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a date' : null,
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
                              initialDate:
                                  _date == null ? DateTime.now() : _date,
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
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Banque'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a bank' : null,
                  onChanged: (value) {
                    setState(() => bank = value);
                  },
                  onTap: () {},
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Débit/Crédit'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a bank' : null,
                  onChanged: (value) {
                    setState(() => operationType = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Organisation'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a bank' : null,
                  onChanged: (value) {
                    setState(() => operationPartner = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Montant'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a bank' : null,
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
          )),
    );
  }
}
