import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/media_horizontal_list.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/skeleton_posters_list_loading.dart';
import '../../logic/top_rated_tv_series/top_rated_tv_series_cubit.dart';

class TopTvSeriesList extends StatelessWidget {
  const TopTvSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      builder: (context, state) {
        if (state is TopRatedTvSeriesLoaded) {
          return MediaHorizontalList(
            mediaType: 'tv',
            items: state.posters,
          );
        } else if (state is TopRatedTvSeriesLoading) {
          return const SkeletonPostersListLoading(height: 260, width: 170);
        } else if (state is TopRatedTvSeriesError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () =>
                context.read<TopRatedTvSeriesCubit>().getTopRatedTvSeries(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
