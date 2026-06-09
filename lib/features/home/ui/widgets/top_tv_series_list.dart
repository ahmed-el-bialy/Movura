import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';

import '../../logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'media_list.dart';

class TopTvSeriesList extends StatelessWidget {
  const TopTvSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      builder: (context, state) {
        if (state is TopRatedTvSeriesLoaded) {
          return MediaList(mediaType: 'tv', posters: state.posters);
        } else if (state is TopRatedTvSeriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TopRatedTvSeriesFailed) {
          return Center(
            child: Text(state.errorMessage, style: Styles.font11BoldGold),
          );
        } else {
          return Center(
            child: Text(
              "there is an error : ${state.toString()}",
              style: Styles.font11BoldGold,
            ),
          );
        }
      },
    );
  }
}
