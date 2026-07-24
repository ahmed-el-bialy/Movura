import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onyxBlack,
                border: Border.all(color: AppColors.neonBlue, width: 2),
              ),
              child: Icon(
                Icons.person_rounded,
                size: 60.sp,
                color: AppColors.neonBlue,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Profile',
              style: AppTextStyles.font24SimiBoldNeonBlueManrope,
            ),
            SizedBox(height: 10.h),
            Text(
              'Cinematic Journey Starts Here',
              style: AppTextStyles.font12CoolGrayManrope,
            ),
          ],
        ),
      ),
    );
  }
}
