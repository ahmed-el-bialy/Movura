import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/custom_posters_grid_view.dart';
import '../../../../core/widgets/skeleton_poster_grid_loading.dart';
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
                    verticalSpacing(12),
                    Text(
                      'No ${state.filter.label.toLowerCase()} found.',
                      style: TextStyles.font14BoldIceBlueMontserrat,
                    ),
                    verticalSpacing(6),
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
