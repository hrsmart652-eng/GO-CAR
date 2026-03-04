

import 'package:flutter/material.dart';

class CustomValueIndicatorShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(80, 40);
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

    final double width = labelPainter.width + 20;
    final double height = labelPainter.height + 14;

    final Rect rect = Rect.fromCenter(
      center: center.translate(0, -45),
      width: width,
      height: height,
    );

    final RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(8),
    );

    final Paint backgroundPaint =
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRRect(roundedRect, backgroundPaint);

    labelPainter.paint(
      canvas,
      Offset(
        rect.left + (width - labelPainter.width) / 2,
        rect.top + (height - labelPainter.height) / 2,
      ),
    );
  }
}
