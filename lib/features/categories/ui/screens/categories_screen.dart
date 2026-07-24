import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_rounded,
              size: 80.sp,
              color: AppColors.neonBlue.withValues(alpha: 0.2),
            ),
            SizedBox(height: 20.h),
            Text(
              'Categories',
              style: AppTextStyles.font24SimiBoldNeonBlueManrope,
            ),
            SizedBox(height: 10.h),
            Text(
              'Coming Soon',
              style: AppTextStyles.font12CoolGrayManrope,
            ),
          ],
        ),
      ),
    );
  }
}
