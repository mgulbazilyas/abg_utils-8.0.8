

/*
// полочка пунктирная
CustomPaint(
    painter: ClipPathClass4Painter(color, 4),
    child: Container(width: 2, height: 100)
  ),

// полоска с квадратом
  CustomPaint(
            painter: ClipPathClass4Painter(Colors.red, 4),
            child: Container(width: 100, height: 100,
                color: Colors.red,)
        ),
 */

import 'package:flutter/material.dart';

class ClipPathClass4Painter extends CustomPainter {
  double s = 10.0;
  Color color = Colors.grey;
  double strokeWidth;

  ClipPathClass4Painter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    bool draw = true;
    for (var i = 0.0; i < size.height; i+=(size.height/15) ) {
      draw = !draw;
      if (i > size.height*0.9)
        break;
      if (draw)
        canvas.drawLine(Offset(0, i), Offset(0, i + size.height / 15), paint);
    }
  }

  @override
  bool shouldRepaint(ClipPathClass4Painter oldDelegate) {
    return false;
  }
}


class ClipPathClass3Painter extends CustomPainter {
  double s = 10.0;
  Color color = Colors.grey;
  double strokeWidth;

  ClipPathClass3Painter(this.s, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

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

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ClipPathClass3Painter oldDelegate) {
    return false;
  }
}

