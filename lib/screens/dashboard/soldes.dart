import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/dashboard/acountState.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';
import 'package:wallet/shared/page_routes.dart';

class Soldes extends StatefulWidget  {
  final String uid;
  final String account;

  Soldes({this.uid, this.account});

  @override
   _SoldesState createState() =>  _SoldesState();
}

class  _SoldesState extends State<Soldes> {
 
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountState>(context);
  
    return new StreamBuilder<List<UserTransaction>>(

        stream: DatabaseService(uid: widget.uid).userTransactions(account: account.accountName),

        builder: (context, snapshot) {

          if (snapshot.hasData) {
            List<UserTransaction> transactions = snapshot.data;
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.remove,
                    color: Colors.orange,
                  ),
                  title: Text(
                    "Dépenses",
                    style: TextStyle(color: Colors.orange),
                  ),
                  trailing: Text(
                      amountsFromUserData(transactions
                                  .where((transaction) =>
                                      transaction.transactionType == 'dépense')
                                  .toList())
                              .isNotEmpty
                          ? amountsFromUserData(transactions
                                  .where((transaction) =>
                                      transaction.transactionType == 'dépense')
                                  .toList())
                              .reduce((a, b) => a + b)
                              .toString()
                          : "0",
                      style: TextStyle(color: Colors.orange)),
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
                      amountsFromUserData(transactions
                                  .where((transaction) =>
                                      transaction.transactionType == "recette")
                                  .toList())
                              .isNotEmpty
                          ? amountsFromUserData(transactions
                                  .where((transaction) =>
                                      transaction.transactionType == "recette")
                                  .toList())
                              .reduce((a, b) => a + b)
                              .toString()
                          : "0",
                      style: TextStyle(color: Colors.green)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, PageRoutes.incomes);
                  },
                )
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
