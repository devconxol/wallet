import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/models/services/auth.dart';
import 'package:wallet/shared/loading.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final user = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(""),
          RaisedButton(
              child: Text('Se déconnecter'),
              onPressed: () async {
                await _auth.signOut();
              }),
        ],
      )),
    );
  }
}
