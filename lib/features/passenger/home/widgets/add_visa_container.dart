import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVisaContainer extends StatefulWidget {
  const AddVisaContainer({
    required this.image,
    required this.text,
    required this.number,
    required this.index,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  final Image image;
  final String text;
  final String number;
  final int index;
  final bool isSelected;
  final Function(int) onSelect;

  @override
  State<AddVisaContainer> createState() => _AddVisaContainerState();
}

class _AddVisaContainerState extends State<AddVisaContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelect(widget.index),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 76.h,
            decoration: BoxDecoration(
              color: widget.isSelected ? const Color(0xffF5FAFF) : Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border:
                  widget.isSelected
                      ? Border.all(color: const Color(0xffBBD1FB), width: 1.w)
                      : Border.all(color: Colors.transparent, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffB4B4B4).withOpacity(0.16),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0.w),
              child: Row(
                children: [
                  widget.image,
                  SizedBox(width: 16.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0.h),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.text,
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff121212),
                            ),
                          ),
                          TextSpan(
                            text: widget.number,
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff344054),
                            ),
                          ),
                        ],
                      ),
                    ),
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
