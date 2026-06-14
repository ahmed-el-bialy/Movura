import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/skeleton_poster_grid_loading.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/poster_card/poster_card.dart';
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
          if (state.posters.isNotEmpty) {
            return Container(
              color: AppColors.jetBlack,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 12.h),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.posters.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .57,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 14.w,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return PosterCard(
                      border: 10,
                      subCardBorder: 10,
                      mediaModel: state.posters[index],
                      elevation: 5,
                      maxLines: 2,
                      titleStyle: Styles.font11BoldIceBlueMontserrat.copyWith(
                        fontSize: 10.sp,
                      ),
                      subTextStyle: Styles.font11BoldIceBlueMontserrat.copyWith(
                        fontSize: 10.sp,
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              color: AppColors.jetBlack,
              child: Center(
                child: Text(
                  'No results found.',
                  style: Styles.font14BoldIceBlueMontserrat,
                ),
              ),
            );
          }
        }

        if (state is SearchFailed) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Container(color: AppColors.richEerieBlack);
      },
    );
  }
}
