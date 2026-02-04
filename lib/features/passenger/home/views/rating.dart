import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  List<String> ratingTexts = ['Worst', 'Bad', 'Okay', 'Good', 'Awesome'];

  List<String> ratingDescriptions = [
    'Worst Experience',
    'Bad Experience',
    'Okay Experience',
    'Good Experience',
    'Awesome Experience',
  ];
  List<String> emojiAssets = [
    'assets/images/worst.png',
    'assets/images/bad.png',
    'assets/images/okay.png',
    'assets/images/good.png',
    'assets/images/awesome.png',
  ];
  List<int> colors = [
    0xffEBEFFF,
    0xffFEF0C7,
    0xffC7F1FE,
    0xffFAD1E0,
    0xffD1FADF,
  ];
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    int selectedIndex = _currentSliderValue.toInt();
    return Scaffold(
      backgroundColor: Color(colors[selectedIndex]), // حسب التصميم
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w, top: 16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Rate the ride",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ratingDescriptions[selectedIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff121212),
                ),
              ),
              SizedBox(height: 24),

              // صورة وجه التقييم *********************************************************
              Image.asset(
                emojiAssets[selectedIndex],
                width: 320.h,
                height: 260.w,
              ),
              SizedBox(height: 24),

              // Slider مع النص    ***********************************************
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorColor: Colors.white,
                  valueIndicatorShape: CustomValueIndicatorShape(),
                  valueIndicatorTextStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff344054),
                  ),
                  trackHeight: 8.0.h,
                  inactiveTrackColor: Colors.white,
                  trackShape: GradientSliderTrackShape(), // 👈 Custom shape
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayColor: Colors.black.withOpacity(0.2),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.white,
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: ratingTexts[selectedIndex],
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 110.h),
              // زر كتابة تعليق
              Row(
                children: [
                  Icon(Icons.messenger, size: 20.sp, color: Color(0xff0D3244)),
                  SizedBox(width: 8),
                  Text(
                    "Write a comment",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Color(0xff0D3244),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              // زر إرسال
              CustomElevatedBtn(
                btnName: 'Submit',
                onPressed: () {
                  if (_currentSliderValue.toInt() == 0) {
                    confirmationDeleteDialog(
                      context,
                      text:
                      'You may don’t see this driver again between your recommendations ,and you  will not be able to change your mind after this message.',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                    );
                  }
                },
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "SKIP",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff0D3244),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

    // 👇 تحكم في الطول (العرض) يدويًا - مثلاً اجعليه 200
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

    // 🎨 gradient فقط لجزء القيمة الحالية
    final Gradient gradient = LinearGradient(
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
      )
      ..style = PaintingStyle.fill;

    // 🟢 ارسم الخلفية البيضاء (كل المسار)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(4)),
      backgroundPaint,
    );

    // 🟣 ارسم الجزء الفعّال بالتدرج (من البداية لحد الـ thumb)
    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, Radius.circular(4)),
      activePaint,
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;

  CustomThumbShape({this.thumbRadius = 12}); // 👈 حجم أساسي

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

    // 👑 دائرة التدرج (كأنها border خارجية)
    final double outerRadius = thumbRadius + 1; // 2px زي border
    final Rect outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final Gradient gradient = LinearGradient(
      colors: [Color(0xFF183E91), Color(0xFF266FFF)], // 🎨 تدرج البوردر
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Paint borderPaint =
    Paint()
      ..shader = gradient.createShader(outerRect)
      ..style = PaintingStyle.fill;

    // ⚪️ دائرة داخلية باللون الأبيض
    final Paint fillPaint =
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // ارسم الدائرة الكبيرة أولاً (تدرج)
    canvas.drawCircle(center, outerRadius, borderPaint);

    // ثم ارسم الدائرة البيضاء فوقها
    canvas.drawCircle(center, thumbRadius, fillPaint);
  }
}

class CustomValueIndicatorShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(80, 40); // مقاس البالونة
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
    final double radius = 8;
    final double arrowHeight = 6;

    // المستطيل الأساسي
    final Rect rect = Rect.fromCenter(
      center: center.translate(0, -45),
      width: width,
      height: height,
    );

    final RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius),
    );

    // ظل خفيف كما في التصميم
    final Paint shadowPaint =
    Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.shift(Offset(0, 2)),
        Radius.circular(radius),
      ),
      shadowPaint,
    );

    // الخلفية البيضاء
    final Paint backgroundPaint =
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRRect(roundedRect, backgroundPaint);

    // السهم السفلي (مثل البالونة)
    final Path arrowPath = Path();
    arrowPath.moveTo(center.dx - 6, rect.bottom);
    arrowPath.lineTo(center.dx, rect.bottom + arrowHeight);
    arrowPath.lineTo(center.dx + 6, rect.bottom);
    arrowPath.close();
    canvas.drawPath(arrowPath, backgroundPaint);

    // النص
    labelPainter.paint(
      canvas,
      Offset(
        rect.left + (width - labelPainter.width) / 2,
        rect.top + (height - labelPainter.height) / 2,
      ),
    );
  }
}
