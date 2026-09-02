import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

import '../../data/models/search_filter_type.dart';
import '../../logic/search/search_cubit.dart';
import '../widgets/search_ui_widgets/search_empty_state.dart';
import 'custom_search_delegate.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.horizontal16(),
          child: Column(
            children: [
              AppSpacing.verticalSpacing(20),
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      searchCubit: sl<SearchCubit>(),
                    ),
                  );
                },
                child: Container(
                  padding: AppSpacing.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.charcoalBlack,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.coolGray.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.neonBlue,
                        size: 24.sp,
                      ),
                      AppSpacing.horizontalSpacing(AppSpacing.m),
                      Text(
                        'Search movies, TV shows...',
                        style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.slateGray.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalSpacing(15),
              SizedBox(
                height: 38.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: SearchFilterType.values.map((filter) {
                    final isSelected = sl<SearchCubit>().currentFilter == filter;
                    return Padding(
                      padding: AppSpacing.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter.label),
                        selected: isSelected,
                        onSelected: (_) {
                          sl<SearchCubit>().updateFilter(filter);
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(
                              searchCubit: sl<SearchCubit>(),
                            ),
                          );
                        },
                        selectedColor: AppColors.neonBlue,
                        backgroundColor: AppColors.charcoalBlack,
                        labelStyle: TextStyle(
                          color: isSelected ? AppColors.trueBlack : AppColors.coolGray,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.neonBlue
                                : AppColors.slateGray.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              AppSpacing.verticalSpacing(10),
              Expanded(
                child: SearchEmptyState(
                  filter: sl<SearchCubit>().currentFilter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
