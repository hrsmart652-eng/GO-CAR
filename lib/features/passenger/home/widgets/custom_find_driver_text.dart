import 'package:flutter/material.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_cubit.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/api/end_points.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../../normal_ride/cubit/normal_ride_cubit.dart';

class CustomFindDriverRequestCancel extends StatefulWidget {
  const CustomFindDriverRequestCancel({
    super.key,
    required this.height,
    required this.context,
    required this.isNormalRide,
    this.normalCubit,
    this.scheduledRideCubit,
  });

  final double? height;
  final BuildContext context;
  final bool isNormalRide;
  final NormalRideCubit? normalCubit;
  final ScheduledRideCubit? scheduledRideCubit;

  @override
  State<CustomFindDriverRequestCancel> createState() =>
      _CustomFindDriverRequestCancelState();
}

class _CustomFindDriverRequestCancelState
    extends State<CustomFindDriverRequestCancel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _wheelAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _wheelAnimation = Tween<double>(
      begin: 0,
      end: 6.28, // 2 * pi = دورة كاملة
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -3), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: -3, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -2), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: -2, end: 0), weight: 25),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: widget.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.isNormalRide ? widget.normalCubit?.normalRide?.price?.toStringAsFixed(0) : widget.scheduledRideCubit?.scheduledRideResponse?.price?.toStringAsFixed(0)} EGP',
                style: TextStyle(
                  foreground:
                      Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFF183E91), Color(0xFF266FFF)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ).createShader(const Rect.fromLTWH(0, 0, 180, 70)),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  confirmationDeleteDialog(
                    text: "Are you sure you want to cancel this trip?",
                    context,
                    title: '',
                    onPressed: () async {
                      // 1. حفظ أداة التنقل في متغير (قبل استخدام await لتجنب مشكلة الـ context unmounted)
                      final navigator = Navigator.of(context);

                      // 2. إغلاق ديالوج التأكيد فقط
                      navigator.pop();

                      try {
                        // 3. انتظار تنفيذ عملية الإلغاء
                        if (widget.isNormalRide) {
                          await cancelNormalRide();
                        } else {
                          await cancelSchduleRide();
                        }

                        // 4. الذهاب للرئيسية ومسح أي شاشات أو Bottom sheets أخرى
                        navigator.pushNamedAndRemoveUntil(
                          widget.isNormalRide ? Routes.home : Routes.schduleHome,
                              (route) => false,
                        );
                      } catch (e) {
                        // لو حصل خطأ في الإلغاء (API Error)، الكود مش هيقف وهيطبع المشكلة هنا
                        debugPrint('Cancel Ride Error: $e');
                        // تقدر مستقبلاً تعرض للمستخدم SnackBar برسالة الفشل هنا
                      }
                    },
                  );
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xffF04438),
                    decorationThickness: 1.2,
                    color: Color(0xffF04438),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ],
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: child,
                );
              },
              child: Image.asset('assets/images/car_outline.png', width: 350),
            ),
          ),
        ],
      ),
    );
  }

  cancelNormalRide() async {
    final tripId = CacheHelper().getData(key: ApiKeys.tripId).toString();

    await widget.normalCubit?.cancelRide(tripId);
   // widget.normalCubit?.resetTrip();

  }

  cancelSchduleRide() async {
    final tripId = CacheHelper().getData(key: ApiKeys.tripId).toString();
    await widget.scheduledRideCubit?.cancelRide(tripId: tripId);
    widget.scheduledRideCubit?.resetTrip();

  }
}
