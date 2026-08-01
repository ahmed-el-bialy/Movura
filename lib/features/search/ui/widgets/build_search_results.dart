import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/custom_posters_grid_view.dart';
import 'package:movura/core/widgets/skeleton_poster_grid_loading.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';

class BuildSearchResultsGrid extends StatelessWidget {
  const BuildSearchResultsGrid({super.key, required this.searchCubit});

  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is SearchLoading) {
          return const SkeletonPosterGridLoading();
        }

        if (state is SearchLoaded) {
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
                      style: TextStyles.font14BoldIceBlueMontserrat,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Try a different keyword or filter',
                      style: TextStyles.font12CoolGrayManrope,
                    ),
                  ],
                ),
              ),
            );
          }


          return Container(
            color: AppColors.jetBlack,
            child: CustomPostersGridView(poster: state.posters),
          );
        }

        if (state is SearchError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () => searchCubit.getSearchResults(query: state.query),
          );
        }

        return Container(color: AppColors.richEerieBlack);
      },
    );
  }
}
