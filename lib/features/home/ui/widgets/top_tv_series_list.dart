import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/skeleton_posters_list_loading.dart';

import '../../logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'posters_list.dart';

class TopTvSeriesList extends StatelessWidget {
  const TopTvSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      builder: (context, state) {
        if (state is TopRatedTvSeriesLoaded) {
          return PostersList(mediaType: 'tv', posters: state.posters);
        } else if (state is TopRatedTvSeriesLoading) {
          return SkeletonPostersListLoading(height: 260, width: 170,);
        } else if (state is TopRatedTvSeriesFailed) {
          return Center(
            child: Text(state.errorMessage, style: AppTextStyles.font11BoldGold),
          );
        } else {
          return Center(
            child: Text(
              "there is an error : ${state.toString()}",
              style: AppTextStyles.font11BoldGold,
            ),
          );
        }
      },
    );
  }
}
