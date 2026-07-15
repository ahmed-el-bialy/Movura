import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/skeleton_poster_grid_loading.dart';

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
          if (state.posters.isNotEmpty) {
            return Container(
              color: AppColors.jetBlack,
              child: CustomPostersGridView(poster: state.posters,),
            );
          } else {
            return Container(
              color: AppColors.jetBlack,
              child: Center(
                child: Text(
                  'No results found.',
                  style: AppTextStyles.font14BoldIceBlueMontserrat,
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
