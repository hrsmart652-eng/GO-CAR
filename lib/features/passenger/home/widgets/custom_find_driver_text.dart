import 'package:flutter/material.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/api/end_points.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../../normal_ride/cubit/normal_ride_cubit.dart';

Widget CustomFindDriverRequestCancel({
  required double? height,
  required BuildContext context,
  required NormalRideCubit normalCubit,
}) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      padding: EdgeInsets.all(12),

      height: height,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${normalCubit.normalRide?.price?.toStringAsFixed(0)} EGP',

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
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xffF04438),
                      decorationThickness: 1.2,
                      color: Color(0xffF04438),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    final tripId = CacheHelper().getData(key: ApiKeys.tripId).toString();
                    confirmationDeleteDialog(
                      text: "Are you sure you want to cancel this trip?",
                      context,
                      onPressed: () async {
                        await normalCubit.cancelRide(tripId);
                      },
                    ).then((value){
                      Navigator.pushNamed(context, Routes.home);
                    });

                  },
                ),
              ],
            ),
            Image.asset('assets/images/car_outline.png', width: 350),
          ],
        ),
      ),
    ),
  );
}
