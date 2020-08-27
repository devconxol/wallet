import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallet/Models/services/database.dart';

class Accounts extends StatefulWidget {
  final String uid;
  Accounts({this.uid});

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
       return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: widget.uid).userAccounts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        
        }

        List accounts = new List();

        snapshot.data.docs.toList().forEach((account) { accounts.add(account);});

        return new ListView(

          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['full_name']),
              subtitle: new Text(document.data()['company']),
            );
          }).toList(),

        );
      },
    );
  }
}