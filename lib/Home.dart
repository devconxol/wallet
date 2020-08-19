import 'package:flutter/material.dart';
 //import 'package:wallet/Settings.dart';
import 'package:wallet/Profil.dart';
import 'package:wallet/Secondhome.dart';
import 'package:wallet/shared/bottom_tabs/bottom_tabs.dart';
 
//import 'HomeScreen.dart';


class HomeScreen extends StatefulWidget {
  static final String path = "lib/src/pages/animations/anim4.dart";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
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

  getPage(int page) {
    switch(page) {
      case 0:
        return SecondhomePage();
      case 1:
        return Profils();

      case 2:
        return
         Center(child: Container(child: Text("Settings")));

    }
  }

}
