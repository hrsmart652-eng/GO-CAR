import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';

import 'add_visa_container.dart';

class addContainer extends StatefulWidget {
  const addContainer({super.key});

  @override
  State<addContainer> createState() => _addContainerState();
}

class _addContainerState extends State<addContainer> {
  int? selectedCardIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Saved Card",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 16.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff121212),
                  ),
                ),
                Spacer(),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.addNewCard);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 104, 107, 112),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Add New Card",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff266FFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.h),
            AddVisaContainer(
              image: Image.asset(
                "assets/images/visa.png",
                width: 38.w,
                height: 38.h,
              ),
              text: "Aareal Bank AG \n",
              number: "XXXXXXXXX236",
              index: 1,
              isSelected: selectedCardIndex == 1,
              onSelect: (index) => setState(() => selectedCardIndex = index),
            ),
            AddVisaContainer(
              image: Image.asset(
                "assets/images/visa1.png",
                width: 38.w,
                height: 38.h,
              ),
              text: "Aareal Bank AG \n",
              number: "XXXXXXXXX236",
              index: 2,
              isSelected: selectedCardIndex == 2,
              onSelect: (index) => setState(() => selectedCardIndex = index),
            ),
          ],
        ),
      ),
    );
  }
}
