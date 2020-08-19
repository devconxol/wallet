import 'package:flutter/material.dart';
import 'package:wallet/Comptes.dart';
import 'package:wallet/Fabottoms.dart';
import 'package:wallet/Transactions.dart';
import 'package:wallet/shared/menu_button.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  MediaQueryData queryData;
  AnimationController animationController;
  Animation translateWalletButton,
      translatePaymentButton,
      translateAddAccountButton;
  Animation rotation;

  double position(double degree) {
    double uniRadian = 57.295779513;
    return degree / uniRadian;
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    translateWalletButton = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);

    translatePaymentButton = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);

    translateAddAccountButton = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);

    rotation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 30,
        bottom: 30,
        child: Stack(children: <Widget>[
          Transform.translate(
            offset: Offset.fromDirection(
                position(180), translateAddAccountButton.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(position(rotation.value))
                ..scale(translateAddAccountButton.value),
              alignment: Alignment.center,
              child: MenuButton()
              //  MyBottoms(
              //     color: Colors.orangeAccent,
              //     width: 55,
              //     height: 55,
              //     icon: Icon(
              //       Icons.payment,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       print("To money...");

              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (_) => TransactionsPage()));
              //     })

              ,
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(
                position(228), translatePaymentButton.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(position(rotation.value))
                ..scale(translatePaymentButton.value),
              alignment: Alignment.center,
              child: MyBottoms(
                  color: Colors.blue[300],
                  width: 60,
                  height: 60,
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => ComptesPage()));
                  }),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(
                position(275), translateWalletButton.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(position(rotation.value))
                ..scale(translateWalletButton.value),
              alignment: Alignment.center,
              child: MyBottoms(
                  color: Colors.white,
                  width: 55,
                  height: 55,
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    print("To money...");
                  }),
            ),
          ),
          Transform(
            transform: Matrix4.rotationZ(position(rotation.value)),
            alignment: Alignment.center,
            child: MyBottoms(
              color: Colors.white,
              width: 60,
              height: 60,
              icon: Icon(
                Icons.menu,
                color: Colors.blue[300],
              ),
              onPressed: () {
                print('Nice');
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
            ),
          ),
        ]));
  }
}

// FabCircularMenu(children: <Widget>[
//         IconButton(
//             icon: Icon(
//               Icons.payment,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TransactionForm()),
//               );
//             }),
//         IconButton(
//             icon: Icon(
//               Icons.payment,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserProfile()),
//               );
//             }),
//         IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               _showAddBankPanel();
//             })
//       ]),
