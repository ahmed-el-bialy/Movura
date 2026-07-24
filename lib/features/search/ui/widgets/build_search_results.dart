import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/skeleton_poster_grid_loading.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/ui/widgets/person_card.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_posters_grid_view.dart';
import '../../logic/search/search_cubit.dart';

class BuildSearchResultsGrid extends StatelessWidget {
  const BuildSearchResultsGrid({super.key, required this.searchCubit});

  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is SearchLoading) {
          return SkeletonPosterGridLoading();
        }

        if (state is SearchFounded) {
          if (state.posters.isEmpty) {
            return Container(
              color: AppColors.jetBlack,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 48.sp,
                      color: AppColors.slateGray.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'No ${state.filter.label.toLowerCase()} found.',
                      style: AppTextStyles.font14BoldIceBlueMontserrat,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Try a different keyword or filter',
                      style: AppTextStyles.font12CoolGrayManrope,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.filter == SearchFilterType.people) {
            return Container(
              color: AppColors.jetBlack,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                physics: const BouncingScrollPhysics(),
                itemCount: state.posters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: PersonCard(
                      person: state.posters[index],
                      width: double.infinity,
                      height: 120,
                    ),
                  );
                },
              ),
            );
          }

          return Container(
            color: AppColors.jetBlack,
            child: CustomPostersGridView(poster: state.posters),
          );
        }

        if (state is SearchFailed) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Text(
                state.errorMessage,
                style: AppTextStyles.font13MediumNeonBlue,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Container(color: AppColors.richEerieBlack);
      },
    );
  }
}
