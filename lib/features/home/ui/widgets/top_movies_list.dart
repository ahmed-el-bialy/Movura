import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/skeleton_posters_list_loading.dart';

import '../../logic/top_rated_movies/top_rated_movies_cubit.dart';
import 'posters_list.dart';

class TopMoviesList extends StatelessWidget {
  const TopMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoaded) {
          return PostersList(mediaType: 'movie', posters: state.posters);
        } else if (state is TopRatedMovieLoading) {
          return SkeletonPostersListLoading(height: 260, width: 170,);
        } else if (state is TopRatedMovieFailed) {
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
