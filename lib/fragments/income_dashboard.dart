import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/fragments/transaction_form.dart';
import 'package:wallet/fragments/transaction_list.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/bank/bank_form.dart';
import 'package:wallet/screens/dashboard/NavigationDrawer.dart';
import 'package:wallet/screens/dashboard/acountState.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';
import 'package:wallet/shared/menu_button.dart';

class IncomeDashboard extends StatelessWidget {
  static const String routeName = '/incomePage';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final account = Provider.of<AccountState>(context);


    void showTransactionPanel(String uid, transactions, String account) {
     
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: TransactionForm(
                account: account,
                btnText: "Enrégistrer",
                transactions: transactions,
                uid: uid,
                title: "Ajouter une recette",
                transactionType: "recette",
              ),
            );
          });
    }

    return StreamBuilder<List<UserTransaction>>(
        stream: DatabaseService(uid: user.uid).userTransactions(account: account.accountName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserTransaction> transactions = snapshot.data
                .where(
                    (transaction) => transaction.transactionType == "recette")
                .toList();

            return new Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Recette',
                      ),
                      Visibility(
                        visible: true,
                        child: Text(
                                                    account.accountName
,
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
                  color: Colors.green,
                  onPressed: () {
                     showTransactionPanel(user.uid, transactions, account.accountName);
                  },
                ));
          } else {
            return Loading();
          }
        });
  }
}
