import 'package:flutter/material.dart';
import 'main.dart';

class DefaultBackground  extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color orangec = Color(0xffFEAC46);
    const Color greyc = Color(0xff494F58);
    const Color bluec = Color(0xff59C0E6);
    var paint = Paint();

    paint.color = bluec;

    Offset c1 = Offset(size.width * 1.0, size.width * 0.3);
    double radius1 = size.width * 1.1;

    canvas.drawCircle(c1, radius1, paint);

    paint.color = greyc;

    Offset c2 = Offset(size.width * 0.05, size.width * 1.8);
    double radius2 = size.width * 0.9;

    canvas.drawCircle(c2, radius2, paint);
  }


  @override
  bool shouldRepaint(DefaultBackground oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DefaultBackground oldDelegate) => false;
}


