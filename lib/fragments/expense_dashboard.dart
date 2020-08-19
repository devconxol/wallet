import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/UserTransaction.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/fragments/transaction_form.dart';
import 'package:wallet/fragments/transaction_list.dart';
import 'package:wallet/screens/dashboard/NavigationDrawer.dart';
import 'package:wallet/services/database.dart';
import 'package:wallet/shared/constants.dart';
import 'package:wallet/shared/loading.dart';
import 'package:wallet/shared/menu_button.dart';

class ExpenseDashboard extends StatelessWidget {
  static const String routeName = '/expensePage';

  @override
  Widget build(BuildContext context) {
    void showTransactionPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: TransactionForm(),
            );
          });
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserTransaction> transactions =
                snapshot.data.accounts[0].transactions..where((transaction) =>
                                    transaction.transactionType == 'dépenses')
                                .toList();
            return new Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red,
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
                  color: Colors.red,
                  onPressed: showTransactionPanel,
                ));
          } else {
            return Loading();
          }
        });
  }
}
