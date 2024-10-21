import 'package:flutter/material.dart';

class ChatGPTLogo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2 - 10;

    // Drawing a circular pattern with lines or curves
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw inner circles or patterns (simplified version)
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(
          Offset(centerX, centerY), radius * (i / 4), paint); // smaller circles
    }

    // Draw connecting lines or arcs (adjust angles and positions for complexity)
    canvas.drawLine(Offset(centerX, centerY - radius),
        Offset(centerX, centerY + radius), paint);
    canvas.drawLine(Offset(centerX - radius, centerY),
        Offset(centerX + radius, centerY), paint);

    // Add more geometric patterns or custom paths here to approximate the look
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: 70,
        child: CustomPaint(
          painter: ChatGPTLogo(),
        ),
      ),
    );
  }
}
