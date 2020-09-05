
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/dashboard/Export.dart';
import 'package:wallet/screens/dashboard/accounts.dart';
import 'package:wallet/screens/dashboard/acountState.dart';
import 'package:wallet/screens/dashboard/soldes.dart';
import 'package:wallet/screens/profile/user_profile.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';
import 'package:wallet/shared/page_routes.dart';
 

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);



     

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            print(userData);
            return Drawer(
              child: ListView(
                children: [
                 UserAccountsDrawerHeader(
                    accountName: Text(userData.name),
                    accountEmail: Text(userData.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        userData.name.substring(0, 1),
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                    
                  // ListTile(
                  //   title: Text(userData.accounts[0].name),
                  // ),
                  Accounts(uid: user.uid),
                     Soldes(uid: user.uid)

                  ,
                  
                  Divider(),
                   
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    title: Text("Profile"),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => UserProfile()));
                    },
                  ), 


                  Export() 
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
