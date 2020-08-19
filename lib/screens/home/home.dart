import 'package:flutter/material.dart';
import 'package:wallet/Profil.dart';
import 'package:wallet/Secondhome.dart';
import 'package:wallet/screens/dashboard/expense_dashboard.dart';
import 'package:wallet/screens/profile/user_profile.dart';
import 'package:wallet/shared/bottom_tabs/bottom_tabs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;

  getPage(int page) {
    switch (page) {
      case 0:
      //  return ExpenseDashboard();
      case 1:
        return UserProfile();
      case 2:
        return Center(child: Container(child: Text("Settings")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Text("Wallet"),
      ), */
      backgroundColor: Colors.grey.shade300,
      body: getPage(_currentPage),
      bottomNavigationBar: BottomTabs(
          currentIndex: _currentPage,
          onChange: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }
}
