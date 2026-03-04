
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';

import 'custom_build_action_horizenation_list_item.dart';

class CustomProfilectionHorzeinatalList extends StatelessWidget {
  const CustomProfilectionHorzeinatalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //-------------------------------- points ---------------
          BuildHorizontalListItem(
            itemImg: 'assets/images/rate_5249368.png',
            itemName: 'Points',
            onTap:
                () => Navigator.pushNamed(context, Routes.pointsScreen),
          ),

          //---------------------------------History ----------------
          BuildHorizontalListItem(
            onTap:
                () => Navigator.pushNamed(context, Routes.historyScreen),
            itemImg: 'assets/images/restore_10302913.png',
            itemName: 'History',
          ),
          //-------------------------- reviews ---------------------
          BuildHorizontalListItem(
            onTap: () {
              Navigator.pushNamed(context, Routes.reviewsScreen);
            },
            itemImg: 'assets/images/review_8632737 1.png',
            itemName: 'Reviews',
          ),
          //-------------------------- Support ---------------------
          BuildHorizontalListItem(
            onTap: () {
              Navigator.pushNamed(context, Routes.supportScreen);
            },
            itemImg: 'assets/images/support_3249904.png',
            itemName: 'Support',
          ),
        ],
      ),
    );
  }
}