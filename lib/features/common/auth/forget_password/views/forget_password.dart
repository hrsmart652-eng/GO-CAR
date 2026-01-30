import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final int otpLength = 6;
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;
  late final List<bool> isFilledList;
  int isFocused = -1;


  Timer? _timer;
  int _start = 180; // 3 دقائق
  bool _isExpired = false;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isExpired = true;
        });
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              Text(
                "Forget Password",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff0D3244)),
              ),
              SizedBox(height: 10.h),
              Text(
                "Please enter the code sent to your mobile number",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff121212)),
              ),
              SizedBox(height: 3.h),
              Text(
                "01012227958",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff475467)),
              ),
              SizedBox(height: 30.h),

              //forget password otp row ****************************************************

              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(otpLength, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 48.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: isFocused == index
                          ? [
                        const BoxShadow(
                          color: Color(0xffFFF8EB),
                          blurRadius: 0,
                          spreadRadius: 4,
                        )
                      ]
                          : [],
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                          color: isFocused == index
                              ? const Color(0xffFEFBDA)
                              : const Color(0xff7F7F7F),
                          width: isFocused == index ? 1.w : 0.5.w),
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
                          fontWeight: FontWeight.w400),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                              color: const Color(0xffFFF8EB), width: 1.w),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                          borderSide: BorderSide(
                              color: isFilledList[index]
                                  ? const Color(0xff121212)
                                  : const Color(0xff7F7F7F),
                              width: isFilledList[index] ? 1.w : 0.5.w),
                        ),
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  );
                }),
              ),
              SizedBox(height: 320.h),

              //forget password otp resend Time Row ****************************************************
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "I didn't receive any code (${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}). ",
                      style: TextStyle(
                          color: Color(0xFF475467),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp
                      ),
                    ),
                    TextSpan(
                      text: "RESEND",
                      style: TextStyle(
                          color: _isExpired ? Color(0xFF266FFF) : Color(0xFF475467)  ,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              CustomElevatedBtn(btnName: "Submit", onPressed: () {
                Navigator.pushNamed(context, Routes.changePassword);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
