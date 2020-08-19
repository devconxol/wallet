import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final color;
  final textcolor;
  final texticon;
  final double height;
  final double width;
  final Icon icon;
  final VoidCallback onPressed;

  MenuButton(
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
    return SizedBox.fromSize(
      size: Size(56, 56), // button width and height
      child: ClipOval(
        child: Material(
          color: color, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: onPressed, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon, // icon
                // text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
