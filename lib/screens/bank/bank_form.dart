import 'package:flutter/material.dart';
import 'package:wallet/models/services/database.dart'; 
import 'package:wallet/shared/constants.dart';

class BankForm extends StatefulWidget {
  @override
  _BankFormState createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  final _formKey = GlobalKey<FormState>();

  String name;

  @override
  Widget build(BuildContext context) {
    DatabaseService database = DatabaseService();
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "Ajouter une nouvelle banque",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (value) =>
                  value.isEmpty ? 'Please enter a name' : null,
              onChanged: (value) {
                setState(() => name = value);
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
                database.updateBank(name);
              },
            )
          ],
        ));
  }
}
