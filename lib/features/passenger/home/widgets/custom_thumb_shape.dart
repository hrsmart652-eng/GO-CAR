
import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;

  CustomThumbShape({this.thumbRadius = 12});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required Size sizeWithOverflow,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double textScaleFactor,
        required double value,
      }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint =
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, fillPaint);
  }
}