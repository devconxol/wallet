import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/services/database.dart';
import 'package:wallet/screens/dashboard/acountState.dart';
import 'package:wallet/screens/dashboard/soldes.dart';

class Accounts extends StatefulWidget  {
  final String uid;
  Accounts({this.uid});
  

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
   String _selectedAccount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _selectedAccount = 'cash'; 
    });
  }
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
        List<String> accounts = new List();

        snapshot.data.docs.toList().forEach((account) {
          accounts.add(account.data()['name'].toString());
        }); 

        //String currentAccount = accounts[0];

        // return Text(accounts[0]['name']);
        return new DropdownButton<String>(

          items: accounts.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),

          value: _selectedAccount,

          onChanged: (value) { 
            setState(() {
              _selectedAccount = value;

               Provider.of<AccountState>(context, listen: false).changeAccount(value);
               
              
            });
          },
          
        );
      },
    );
  }
}
