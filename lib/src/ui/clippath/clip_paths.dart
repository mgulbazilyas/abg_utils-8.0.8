import 'package:flutter/material.dart';

/*
ClipPath(
    clipper: ClipPathClass3(10),
    child: Container(
      width: 100, height: 100,
      color: Colors.red,
    ))

 */


class ClipPathClass1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width-10, size.height/2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ClipPathClass2 extends CustomClipper<Path> {
  double s = 10;
  ClipPathClass2(this.s);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, s);
    path.cubicTo(0, s,
        0, 0,
        s, 0);
    path.lineTo(size.width-s, 0);
    path.lineTo(size.width, s);
    path.lineTo(size.width, size.height-s);
    path.lineTo(size.width-s, size.height);
    path.lineTo(s, size.height);
    path.cubicTo(s, size.height,
        0, size.height,
        0, size.height-s);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ClipPathClass3 extends CustomClipper<Path> {
  double s = 10;
  ClipPathClass3(this.s);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, s);
    path.lineTo(s, 0);
    path.lineTo(size.width-s, 0);
    path.cubicTo(size.width-s, 0,
        size.width, 0,
        size.width, s);
    path.lineTo(size.width, size.height-s);
    path.cubicTo(size.width, size.height-s,
        size.width, size.height,
        size.width-s, size.height);
    path.lineTo(s, size.height);
    path.lineTo(0, size.height-s);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
