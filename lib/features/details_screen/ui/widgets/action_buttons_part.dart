import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ActionButtonsPart extends StatelessWidget {
  const ActionButtonsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonCyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill_outlined,
                    color: AppColors.trueBlack,
                    size: 20.sp,
                  ),
                  Text(" WATCH TRAILER", style: Styles.font17TrueBlackBoldSora),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonCyan,

              shape: CircleBorder(),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(Icons.add, color: AppColors.trueBlack, size: 30.sp),
            ),
          ),
        ],
      ),
    );
  }
}
