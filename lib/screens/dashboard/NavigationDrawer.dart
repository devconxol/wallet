import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/screens/profile/user_profile.dart';
import 'package:wallet/services/database.dart';
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
    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;

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
                  ListTile(
                    leading: Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Dépenses",
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: Text(
                        amountsFromUserData(userData.accounts[0].transactions
                                .where((transaction) =>
                                    transaction.transactionType == 'dépense')
                                .toList())
                            .reduce((a, b) => a + b)
                            .toString(),
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, PageRoutes.expenses);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Recettes",
                      style: TextStyle(color: Colors.green),
                    ),
                    trailing: Text(
                        amountsFromUserData(userData.accounts[0].transactions
                                .where((transaction) =>
                                    transaction.transactionType == 'recette')
                                .toList())
                            .reduce((a, b) => a + b)
                            .toString(),
                        style: TextStyle(color: Colors.green)),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, PageRoutes.incomes);
                    },
                  ),
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
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
