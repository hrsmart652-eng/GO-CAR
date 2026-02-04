import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';

import '../../../../../core/widgets/custom_elevated_btn.dart';

class PhoneNumberOtp extends StatefulWidget {
  const PhoneNumberOtp({super.key});

  @override
  State<PhoneNumberOtp> createState() => _PhoneNumberOtpState();
}

class _PhoneNumberOtpState extends State<PhoneNumberOtp> {
  final int otpLength = 6;
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;
  late final List<bool> isFilledList;
  int isFocused = -1;

  Timer? _timer;
  int _start = 180; // 3 دقائق
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {});
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    /// The [FocusNode]s are initialized here and their listeners are added.
    _focusNodes = List.generate(otpLength, (index) {
      final node = FocusNode();
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            isFocused = index;
          });
        } else {
          setState(() {
            isFocused = -1;
          });
        }
      });
      return node;
    });

    _controllers = List.generate(otpLength, (_) => TextEditingController());
    isFilledList = List.generate(otpLength, (_) => false);
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    setState(() {
      isFilledList[index] = value.isNotEmpty;
    });

    // لصق كود مرة واحدة
    if (value.length > 1) {
      final characters = value.split('');
      for (int i = 0; i < otpLength; i++) {
        if (i < characters.length) {
          _controllers[i].text = characters[i];
          isFilledList[i] = true;
        }
      }
      _focusNodes[index].unfocus();
      setState(() {
        isFocused = -1;
      });
      return;
    }

    // التنقل للأمام عند إدخال رقم
    if (value.length == 1 && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // الرجوع للخلف عند حذف الرقم
    else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: const Text(
            'Phone Number OTP',
            style: TextStyle(
              color: Color(0xFF0D3244),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40.0.w, right: 16.w, left: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //---------------------  car  ---------------------
            SizedBox(
              height: 40.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 6.h,
                    width: 208.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff183E91),
                          Color(0xff04034C),
                          // Color(0xff04034C),
                          Color(0xFFEAECF0),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.center,
                        stops: const [0.0, 1.0, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 104.w,
                    top: -9.h,
                    child: SvgPicture.asset('assets/images/car_line.svg'),
                  ),
                ],
              ),
            ),

            //-------------------------timer------------------------
            Text(
              '${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF266FFF),
                fontWeight: FontWeight.w500,
              ),
            ),

            //---------------------  otp field -------------------
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(otpLength, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: 48.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:
                        isFocused == index
                            ? [
                              const BoxShadow(
                                color: Color(0xffFFF8EB),
                                blurRadius: 0,
                                spreadRadius: 4,
                              ),
                            ]
                            : [],
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color:
                          isFocused == index
                              ? const Color(0xffFEFBDA)
                              : const Color(0xff7F7F7F),
                      width: isFocused == index ? 1.w : 0.5.w,
                    ),
                  ),
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "__",
                      hintStyle: TextStyle(
                        wordSpacing: 0,
                        fontWeight: FontWeight.w100,
                        fontSize: 20.sp,
                        color: const Color(0xff9D9D9D),
                      ),
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: BorderSide(
                          color: const Color(0xffFFF8EB),
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: BorderSide(
                          color:
                              isFilledList[index]
                                  ? const Color(0xff121212)
                                  : const Color(0xff7F7F7F),
                          width: isFilledList[index] ? 1.w : 0.5.w,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onChanged(value, index),
                  ),
                );
              }),
            ),

            //---------------------  next button ------------------
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I didn\'t receive any code.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign up screen
                  },
                  child: Text(
                    'RESEND',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF266FFF),
                    ),
                  ),
                ),
              ],
            ),
            CustomElevatedBtn(
              onPressed: () {
                Navigator.pushNamed(context, Routes.driverCongratulations);
              },
              btnName: 'Next',
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ),
    );
  }
}
