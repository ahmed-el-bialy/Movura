import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
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
          return const SkeletonPostersListLoading(height: 260, width: 170);
        } else if (state is TopRatedTvSeriesError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () => context.read<TopRatedTvSeriesCubit>().getTopRatedTvSeries(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
