import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/layout/media_horizontal_list.dart';
import 'package:movura/core/widgets/loading/skeleton_posters_list_loading.dart';
import '../../logic/trending_content/trending_content_cubit.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingContentCubit, TrendingContentState>(
      builder: (context, state) {
        if (state is TrendingContentLoading) {
          return const SliverToBoxAdapter(child: SkeletonPostersListLoading());
        } else if (state is TrendingContentLoaded) {
          return SliverToBoxAdapter(
            child: MediaHorizontalList(
              showMediaType: true,
              items: state.posters,
              height: 330,
              cardWidth: 220,
            ),
          );
        } else if (state is TrendingContentError) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () =>
                  context.read<TrendingContentCubit>().getTrendingPosters(),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
