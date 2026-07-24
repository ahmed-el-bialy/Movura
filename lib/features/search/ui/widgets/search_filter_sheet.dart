import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';

class SearchFilterSheet extends StatelessWidget {
  const SearchFilterSheet({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final SearchFilterType selectedFilter;
  final ValueChanged<SearchFilterType> onFilterSelected;

  static Future<SearchFilterType?> show(
    BuildContext context, {
    required SearchFilterType selectedFilter,
  }) {
    return showModalBottomSheet<SearchFilterType>(
      context: context,
      backgroundColor: AppColors.charcoalBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => SearchFilterSheet(
        selectedFilter: selectedFilter,
        onFilterSelected: (filter) => Navigator.pop(context, filter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.slateGray.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Filter Results',
              style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Choose what type of content to show',
              style: AppTextStyles.font12CoolGrayManrope.copyWith(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),
            ...SearchFilterType.values.map((filter) {
              final isSelected = filter == selectedFilter;
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Material(
                  color: isSelected
                      ? AppColors.neonBlue.withValues(alpha: 0.12)
                      : AppColors.onyxBlack,
                  borderRadius: BorderRadius.circular(16.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    splashColor: AppColors.neonBlue.withValues(alpha: 0.2),
                    onTap: () => onFilterSelected(filter),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.neonBlue.withValues(alpha: 0.6)
                              : AppColors.slateGray.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _iconFor(filter),
                            color: isSelected
                                ? AppColors.neonBlue
                                : AppColors.slateGray,
                            size: 22.sp,
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            filter.label,
                            style: (isSelected
                                    ? AppTextStyles.font13BoldNeonBlueSora
                                    : AppTextStyles.font14PureWhiteManrope)
                                .copyWith(fontSize: 14.sp),
                          ),
                          const Spacer(),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.neonBlue,
                              size: 22.sp,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(SearchFilterType filter) {
    return switch (filter) {
      SearchFilterType.all => Icons.grid_view_rounded,
      SearchFilterType.movies => Icons.movie_outlined,
      SearchFilterType.tv => Icons.tv_outlined,
      SearchFilterType.people => Icons.person_outline_rounded,
    };
  }
}
