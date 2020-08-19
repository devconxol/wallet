import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:wallet/Profil.dart';
import 'package:wallet/Secondhome.dart';
import 'package:wallet/default_background.dart';
import 'package:wallet/screens/bank/bank_form.dart';
import 'package:wallet/screens/bank/transaction_form.dart';
import 'package:wallet/screens/dashboard/NavigationDrawer.dart';
import 'package:wallet/screens/home/main_menu.dart';
import 'package:wallet/screens/profile/user_profile.dart';
import 'package:wallet/shared/bottom_tabs/bottom_tabs.dart';
import 'package:wallet/shared/menu_button.dart';

class ExpenkseDashboard extends StatelessWidget {
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    void _showAddBankPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: BankForm(),
            );
          });
    }

    void _showTransactionPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: TForm(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
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
          height: queryData.size.height,
          child: Stack(
            children: [
              CustomPaint(
                painter: DefaultBackground(),
                child: Container(),
              ),

              // MainMenu()
            ],
          ),
        ),
        floatingActionButton: MenuButton(icon: Icon(Icons.add),));
  }
}
