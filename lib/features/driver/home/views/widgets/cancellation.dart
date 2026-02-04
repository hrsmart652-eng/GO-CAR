import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_elevated_btn.dart';

class Cancellation extends StatelessWidget {
  const Cancellation({super.key});

  void _showAnotherReasonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(12),
            height: 250,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Are you sure?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: 343.w,
                  decoration: BoxDecoration(
                    color: Color(0xff266FFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomElevatedBtn(
                    btnName: 'Yes',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: 343.w,
                  decoration: BoxDecoration(
                    color: Color(0xffF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xffD0D5DD)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xff266FFF),

                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ), // Placeholder
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      // height: 470,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: Text(
              'Reason for cancellation?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: 343.w,
            decoration: BoxDecoration(
              color: Color(0xff266fff),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomElevatedBtn(
              btnName: 'The passenger didn\'t come',
              onPressed: () {
                Navigator.pop(context);
                _showAnotherReasonSheet(context);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 343.w,
            decoration: BoxDecoration(
              color: Color(0xff266FFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomElevatedBtn(
              btnName: 'Fake request',
              onPressed: () {
                Navigator.pop(context);
                _showAnotherReasonSheet(context);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 343.w,
            decoration: BoxDecoration(
              color: Color(0xff266FFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomElevatedBtn(
              btnName: 'Rude passenger',
              onPressed: () {
                Navigator.pop(context);
                _showAnotherReasonSheet(context);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 343.w,
            decoration: BoxDecoration(
              color: Color(0xff266FFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomElevatedBtn(
              btnName: 'I have an issue with my car',
              onPressed: () {
                Navigator.pop(context);
                _showAnotherReasonSheet(context);
              },
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: 343.w,
            decoration: BoxDecoration(
              color: Color(0xffF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffD0D5DD)),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff266FFF),

                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
