import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/models/services/auth.dart';
 import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';

class RegisterBusinessForm extends StatefulWidget {
  final Function toggleView;
  RegisterBusinessForm({this.toggleView});

  @override
  _RegisterBusinessFormState createState() => _RegisterBusinessFormState();
}

class _RegisterBusinessFormState extends State<RegisterBusinessForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: "Entreprise"),
                  validator: (value) =>
                      value.isEmpty ? 'Veillez entrez votre nom' : null,
                  onChanged: (value) {
                    setState(() => name = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (value) =>
                      value.isEmpty ? 'Entrer un email' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: "Mot de passe"),
                  validator: (value) => value.length < 6
                      ? 'Au moins 6 characters pour le mot de passe'
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.orange[400],
                    child: Text(
                      "S'enrégister",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);

                        dynamic result =
                            await _auth.registerBusinessWithEmailAndPassword(
                                email, password, name);

                        if (result == null) {
                          setState(() {
                            error = 'Vous êtes déjà enrégistré avec cet email';
                            loading = false;
                          });
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ));
  }
}
