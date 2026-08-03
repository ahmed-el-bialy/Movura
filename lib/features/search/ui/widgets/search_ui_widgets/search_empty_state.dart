import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

import '../../../data/models/search_filter_type.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key, required this.filter});

  final SearchFilterType filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.richEerieBlack,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 56.sp,
              color: AppColors.neonBlue.withValues(alpha: 0.4),
            ),
            AppSpacing.verticalSpacing(AppSpacing.l),
            Text(
              'Search Movura',
              style: TextStyles.font20SemiBoldNeonBlueManrope.copyWith(
                fontSize: 18.sp,
              ),
            ),
            AppSpacing.verticalSpacing(AppSpacing.s),
            Text(
              filter == SearchFilterType.all
                  ? 'Find movies, TV shows, and people'
                  : 'Showing ${filter.label.toLowerCase()} only',
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
