import 'package:flutter/material.dart';
import 'package:wallet/Comptes.dart';
import 'package:wallet/Home.dart';
import 'package:wallet/Transactions.dart';
import 'main.dart';
import 'default_background.dart';
import 'Fabottoms.dart';
import 'Transactions.dart';
import 'Comptes.dart';
import 'package:provider/provider.dart';
import 'Card.dart';

class SecondhomePage extends StatefulWidget {
  @override
  _SecondhomePageState createState() => _SecondhomePageState();
}

class _SecondhomePageState extends State<SecondhomePage>
    with SingleTickerProviderStateMixin {
  MediaQueryData queryData;
  AnimationController animationController;
  Animation translation, translation_two, translation_three;
  Animation rotation;

  double position(double degree) {
    double uniRadian = 57.295779513;
    return degree / uniRadian;
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    translation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);

    translation_two = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);

    translation_three = TweenSequence([
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
    Size size = MediaQuery.of(context).size;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: queryData.size.height,

        child: Stack(
          children: [
            CustomPaint(
              painter: DefaultBackground(),
              child: Container(),
            ),
            // Positioned(
            //   right: 30,
            //   bottom: 30,
            //   child: Stack(children: <Widget>[
            //     Transform.translate(
            //       offset: Offset.fromDirection(
            //           position(180), translation_three.value * 100),
            //       child: Transform(
            //         transform: Matrix4.rotationZ(position(rotation.value))
            //           ..scale(translation_three.value),
            //         alignment: Alignment.center,
            //         child: MyBottoms(
            //             color: Colors.orangeAccent,
            //             width: 55,
            //             height: 55,
            //             icon: Icon(
            //               Icons.payment,
            //               color: Colors.black,
            //             ),
            //             onPressed: () {
            //               Navigator.of(context).push(MaterialPageRoute(
            //                   builder: (_) => TransactionsPage()));
            //             }),
            //       ),
            //     ),
            //     Transform.translate(
            //       offset: Offset.fromDirection(
            //           position(228), translation_two.value * 100),
            //       child: Transform(
            //         transform: Matrix4.rotationZ(position(rotation.value))
            //           ..scale(translation_two.value),
            //         alignment: Alignment.center,
            //         child: MyBottoms(
            //             color: Colors.blue[300],
            //             width: 60,
            //             height: 60,
            //             icon: Icon(
            //               Icons.monetization_on,
            //               color: Colors.black,
            //             ),
            //             onPressed: () {
            //               Navigator.of(context).push(
            //                   MaterialPageRoute(builder: (_) => ComptesPage()));
            //             }),
            //       ),
            //     ),
            //     Transform.translate(
            //       offset: Offset.fromDirection(
            //           position(275), translation.value * 100),
            //       child: Transform(
            //         transform: Matrix4.rotationZ(position(rotation.value))
            //           ..scale(translation.value),
            //         alignment: Alignment.center,
            //         child: MyBottoms(
            //             color: Colors.white,
            //             width: 55,
            //             height: 55,
            //             icon: Icon(
            //               Icons.add_circle,
            //               color: Colors.black,
            //             ),
            //             onPressed: () {}),
            //       ),
            //     ),
                
            //   ]),
            // )
           /* 
            ListView.builder(
              itemBuilder:(context,index) => Text("hdfjhdfd"))  */
          ],
        ),
      ),
    );
  }
}

class Transactions {}
