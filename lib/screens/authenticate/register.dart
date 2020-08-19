import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/services/auth.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        : Scaffold(
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
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Nom & Prénoms"),
                          validator: (value) =>
                              value.isEmpty ? 'Veillez entrez votre nom' : null,
                          onChanged: (value) {
                            setState(() => name = value);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          validator: (value) =>
                              value.isEmpty ? 'Entrer un email' : null,
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Mot de passe"),
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
                                    await _auth.registerWithEmailAndPassword(
                                        email, password, name);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Vous êtes déjà enrégistré avec cet email';
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
                    )),
              ),
            ));
  }
}
