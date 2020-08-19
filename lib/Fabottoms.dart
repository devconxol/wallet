import 'package:flutter/material.dart';

class MyBottoms extends StatelessWidget {
  final color;
  final textcolor;
  final texticon;
  final double height;
  final double width;
  final Icon icon;
  final VoidCallback onPressed;

  MyBottoms(
      {this.color,
      this.textcolor,
      this.texticon,
      this.height,
      this.width,
      this.icon,
      this.onPressed,
      List<Widget> children});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IconButton(
        tooltip: 'dfdfd',
        icon: icon,
        enableFeedback: true,
        onPressed: onPressed,
      ),
    );

    /*  child: 
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            texticon,
          ),
        ],
       ), */
  }
}
