import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/layout/custom_posters_grid_view.dart';
import 'package:movura/core/widgets/loading/skeleton_poster_grid_loading.dart';
import '../../logic/search/search_cubit.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({super.key, required this.searchCubit});

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
                    AppSpacing.verticalSpacing(AppSpacing.m),
                    Text(
                      'No ${state.filter.label.toLowerCase()} found.',
                      style: TextStyles.font14BoldIceBlueMontserrat,
                    ),
                    AppSpacing.verticalSpacing(6),
                    Text(
                      'Try a different keyword or filter',
                      style: TextStyles.font12RegularCoolGrayManrope,
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            color: AppColors.jetBlack,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent * 0.9) {
                  searchCubit.loadMore();
                }
                return false;
              },
              child: CustomPostersGridView(
                posters: state.posters,
                isLoadingMore: state.isLoadingMore,
                hasReachedMax: state.hasReachedMax,
              ),
            ),
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
