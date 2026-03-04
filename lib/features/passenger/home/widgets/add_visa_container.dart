import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVisaContainer extends StatelessWidget {
  const AddVisaContainer({
    super.key,
    required this.image,
    required this.text,
    required this.number,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  });

  final Image image;
  final String text;
  final String number;
  final int index;
  final bool isSelected;
  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => onSelect(index),

      child: Column(
        children: [

          Container(
            width: double.infinity,
            height: 76.h,

            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xffF5FAFF)
                  : Colors.white,

              borderRadius: BorderRadius.circular(8.r),

              border: Border.all(
                color: isSelected
                    ? const Color(0xffBBD1FB)
                    : Colors.transparent,
                width: 1.w,
              ),

              boxShadow: [
                BoxShadow(
                  color: const Color(0xffB4B4B4).withOpacity(0.16),
                  blurRadius: 10,
                  offset: Offset.zero,
                ),
              ],
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),

              child: Row(
                children: [

                  /// Card Image
                  image,

                  SizedBox(width: 16.w),

                  /// Texts
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          text,
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff121212),
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          number,
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 13.sp,
                            color: const Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isSelected)
                    const Icon(
                      Icons.check_circle_outline_sharp,
                      color: Color(0xff266FFF),
                      size: 22,
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
