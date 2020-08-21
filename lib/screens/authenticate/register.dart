import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/screens/authenticate/register_business_form.dart';
import 'package:wallet/screens/authenticate/register_personal_form.dart';
 import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';

class Register extends StatefulWidget {
  static const String routeName = '/registerPage';

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 
  int group = 1; 
  bool isPersonel = true;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              title: Text("S'enrégistrer"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Se connecter"))
              ],
            ),
            body: CustomPaint(
              painter: DefaultBackground(),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          RadioListTile(
                              title: const Text('Personel'),
                              value: 1,
                              groupValue: group,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  group = value;
                                  isPersonel = !isPersonel;
                                });
                              }),
                          RadioListTile(
                              title: const Text('Entreprise'),
                              value: 2,
                              groupValue: group,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  group = value;
                                  isPersonel = !isPersonel;
                                });
                              })
                        ],
                      ),
                      isPersonel
                      ? 
                      RegisterPersonalForm() : 
                      RegisterBusinessForm()
                    ],
                  )),
            ));
  }
} 