import 'package:flutter/material.dart';

import '../routing/routes.dart';

Future<void> confirmationDeleteDialog(
  BuildContext context, {
  required String text,
  required String title,
  required Future<void>? Function() onPressed,
}) {
  bool isLoading = false;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/cancel_delete.png',
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Are you sure!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0D3244),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff475467),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xffF9FAFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Color(0xffD0D5DD),
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xff183E91),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffD92D20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // confirmation_delete_dialog.dart
                          onPressed: isLoading
                              ? null
                              : () async {
                            setState(() {
                              isLoading = true; // أولاً
                            });

                            await onPressed(); // بس، من غير .then

                            if (context.mounted) {
                              Navigator.pop(context); // إغلاق الدايلوج بس
                            }
                          },
                          child:
                              isLoading
                                  ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
  );
}
