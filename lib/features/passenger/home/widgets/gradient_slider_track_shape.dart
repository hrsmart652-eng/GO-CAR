
import 'package:flutter/material.dart';

class GradientSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;

    final double customTrackWidth = 300.0;

    final double trackLeft =
        offset.dx + (parentBox.size.width - customTrackWidth) / 2;

    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    return Rect.fromLTWH(trackLeft, trackTop, customTrackWidth, trackHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isEnabled = false,
        bool isDiscrete = false,
        required TextDirection textDirection,
      }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint backgroundPaint =
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Gradient gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple],
    );

    final Paint activePaint =
    Paint()
      ..shader = gradient.createShader(
        Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          thumbCenter.dx,
          trackRect.bottom,
        ),
      );

    // Background
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(4)),
      backgroundPaint,
    );

    // Active
    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(4)),
      activePaint,
    );
  }
}