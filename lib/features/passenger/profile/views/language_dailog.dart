import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> languageDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      int selectedIndex = 0;
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: 372.w,
            height: 112.h,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 295.w,
                    child: ListTile(
                      title: Text(
                        'English',
                        style:
                            selectedIndex == 0
                                ? TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff13190B),
                                )
                                : TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff13190B),
                                ),
                      ),
                      trailing:
                          selectedIndex == 0
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 295.w,
                    child: ListTile(
                      title: Text(
                        'Arabic',
                        style:
                            selectedIndex == 0
                                ? TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff13190B),
                                )
                                : TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff13190B),
                                ),
                      ),
                      trailing:
                          selectedIndex == 1
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
