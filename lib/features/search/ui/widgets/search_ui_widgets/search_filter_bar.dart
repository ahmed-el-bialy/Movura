import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key, required this.searchCubit});

  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: BlocBuilder<SearchCubit, SearchState>(
        buildWhen: (previous, current) =>
            current is SearchInitial ||
            current is SearchLoaded ||
            current is SearchLoading,
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.horizontal(16),
            physics: const BouncingScrollPhysics(),
            itemCount: SearchFilterType.values.length,
            itemBuilder: (context, index) {
              final filter = SearchFilterType.values[index];
              final isSelected = searchCubit.currentFilter == filter;
              return Padding(
                padding: AppSpacing.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter.label),
                  selected: isSelected,
                  onSelected: (_) => searchCubit.setFilter(filter),
                  selectedColor: AppColors.neonBlue,
                  backgroundColor: AppColors.charcoalBlack,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.trueBlack
                        : AppColors.coolGray,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.neonBlue
                          : AppColors.slateGray.withValues(
                              alpha: 0.15,
                            ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
