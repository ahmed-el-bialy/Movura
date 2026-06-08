import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home_screen/logic/top_rated_movie/top_rated_movie_cubit.dart';

import 'media_list.dart';

class TopMoviesList extends StatelessWidget {
  const TopMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoaded) {
          return MediaList(mediaType: 'movie', posters: state.posters,);
        } else if (state is TopRatedMovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TopRatedMovieFailed) {
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
