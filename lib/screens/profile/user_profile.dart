import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/models/services/auth.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/bank/bank_form.dart';
import 'package:wallet/shared/loading.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final user = Provider.of<UserData>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: ListView(
              children:  <Widget>[
            SizedBox(height: 20),

            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1599119205399-a005669171bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80"), fit: BoxFit.cover)
                    )
                  ),
                  Text(userData.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(userData.email)
                ]
              ),
            ),
             
              RaisedButton(
                color: Colors.greenAccent,
                  child: Text('Ajouter un nouveau compte', style: TextStyle(),),
                  onPressed: () async {
                      showModalBottomSheet(
              context: context,
              builder: (context) {
                return   Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                  child: BankForm(uid: user.uid),
                ) 
                ;
              });

                   }),
                  Divider(),



                    RaisedButton(
                color: Colors.redAccent,

                  child: Text('Se déconnecter', style: TextStyle(color: Colors.white),  ),
                  onPressed: () async {
                    await _auth.signOut();
                  }),
            ],
          ));
        } else {
          return Loading();
        }
        
      }
    );
  }
}
