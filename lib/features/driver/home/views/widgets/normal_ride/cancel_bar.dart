import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/home/views/widgets/cancellation.dart';

class CancelBar extends StatelessWidget {
  const CancelBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text(
              'Cancel ride',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffF04438),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Cancellation(),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              );
            },
          ),
          ClipOval(
            child: Container(
              width: 45.w,
              height: 45.w,
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/sos.png',
                    width: 30.w,
                    height: 30.w,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/sos_frame.png',
                    width: 30.w,
                    height: 30.w,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.sos, color: Colors.white, size: 20),
                      splashRadius: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
