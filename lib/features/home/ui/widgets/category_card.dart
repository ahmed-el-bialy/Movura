import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

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
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              model.color.withValues(alpha: 0.8),
              model.color.withValues(alpha: 0.4),
            ],
          ),
          border: Border.all(
            color: model.color.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: model.color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Positioned(
                bottom: -10.h,
                right: -10.w,
                child: Icon(
                  model.icon,
                  color: Colors.white.withValues(alpha: 0.1),
                  size: 80.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        model.icon,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    const Spacer(),
                    if (model.hint != null)
                      Text(
                        model.hint!.toUpperCase(),
                        style: AppTextStyles.font10BoldCoolGray.copyWith(
                          color: Colors.white.withValues(alpha: 0.6),
                          letterSpacing: 1.2,
                          fontSize: 9.sp,
                        ),
                      ),
                    SizedBox(height: 4.h),
                    Text(
                      model.title,
                      style: AppTextStyles.font14BoldIceBlueMontserrat.copyWith(
                        fontSize: 13.sp,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
