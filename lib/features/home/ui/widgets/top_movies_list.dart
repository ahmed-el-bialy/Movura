import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/home/ui/widgets/posters_list.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/skeleton_posters_list_loading.dart';
import '../../logic/top_rated_movies/top_rated_movies_cubit.dart';

class TopMoviesList extends StatelessWidget {
  const TopMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoaded) {
          return PostersList(mediaType: 'movie', posters: state.posters);
        } else if (state is TopRatedMovieLoading) {
          return const SkeletonPostersListLoading(height: 260, width: 170);
        } else if (state is TopRatedMovieError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () =>
                context.read<TopRatedMovieCubit>().getTopRatedMovies(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
