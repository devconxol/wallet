import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/fragments/transaction_form.dart';
import 'package:wallet/fragments/transaction_list.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/dashboard/NavigationDrawer.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';
import 'package:wallet/shared/menu_button.dart';

class ExpenseDashboard extends StatelessWidget {
  static const String routeName = '/expensePage';

  @override
  Widget build(BuildContext context) {
    void showTransactionPanel(String uid, transactions) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: TransactionForm(
                btnText: "Enrégistrer",
                uid: uid,
                title: "Ajouter une dépense",
                transactionType: "dépense",
              ),
            );
          });
    }

    final user = Provider.of<UserData>(context);

    return StreamBuilder<List<UserTransaction>>(
        stream: DatabaseService(uid: user.uid).userTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserTransaction> transactions = snapshot.data
                .where(
                    (transaction) => transaction.transactionType == "dépense")
                .toList();
            return new Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.orange,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dépenses',
                      ),
                      Visibility(
                        visible: true,
                        child: Text(
                          'Tous les comptes / 1 Août 2020 - 30 Août 2020',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                drawer: NavigationDrawer(),
                body: Container(
                  //  height: queryData.size.height,
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: DefaultBackground(),
                        child: TransactionList(
                          uid: user.uid,
                          transactions: transactions,
                        ),
                      ),

                      // MainMenu()
                    ],
                  ),
                ),
                floatingActionButton: MenuButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    showTransactionPanel(user.uid, transactions);
                  },
                ));
          } else {
            return Loading();
          }
        });
  }
}
