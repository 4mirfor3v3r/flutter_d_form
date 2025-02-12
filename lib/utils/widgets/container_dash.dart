import 'package:flutter/material.dart';

class ContainerDashRect extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  ContainerDashRect({
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashRectPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class DashRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashRectPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(borderRadius.toRRect(Rect.fromLTWH(0, 0, size.width, size.height)));

    final dashPath = Path();
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(distance, distance + dashWidth);
        dashPath.addPath(segment, Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}