import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/screens/custom_search_delegate.dart';
import 'package:movura/features/search/ui/widgets/search_ui_widgets/search_empty_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpacing(20),
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(searchCubit: sl<SearchCubit>()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.charcoalBlack,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.coolGray.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, color: AppColors.neonBlue, size: 24.sp),
                      horizontalSpacing(12),
                      Text(
                        'Search movies, TV shows...',
                        style: TextStyles.font12CoolGrayManrope.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.slateGray.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SearchEmptyState(filter: sl<SearchCubit>().currentFilter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
