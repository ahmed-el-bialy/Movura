import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';

import '../../data/models/category_card_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.model, required this.onTap});

  final CategoryCardModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              model.color[900]!,
              model.color[800]!,
              model.color[700]!,
              model.color[500]!,
              model.color[600]!,
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 15.h,
              right: 15.w,
              child: Icon(
                model.icon,
                color: AppColors.iceBlue.withValues(alpha: .3),
                size: 75.sp,
              ),
            ),
            Positioned(
              left: 15.w,
              bottom: 45.h,
              child: Text(
                model.hint ?? "",
                style: Styles.font14PureWhiteManrope.copyWith(
                  color: AppColors.platinumGray.withValues(alpha: .8),
                ),
              ),
            ),
            Positioned(
              left: 15.w,
              bottom: 20.h,
              child: Text(
                model.title,
                style: Styles.font14PureWhiteManrope.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.platinumGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
