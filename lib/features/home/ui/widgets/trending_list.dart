import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/home/ui/widgets/trending_poster_list.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/poster_card_skeleton.dart';
import '../../logic/trending_content/trending_content_cubit.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingContentCubit, TrendingContentState>(
      builder: (context, state) {
        if (state is TrendingContentLoading) {
          return SliverToBoxAdapter(child: PosterCardSkeleton());
        } else if (state is TrendingContentLoaded) {
          return SliverToBoxAdapter(
            child: TrendingPosterList(trendingContent: state.posters),
          );
        } else if (state is TrendingContentFailed) {
          return SliverToBoxAdapter(
            child: Text(state.errorMessage, style: Styles.font13MediumNeonCyan),
          );
        } else {
          return SliverToBoxAdapter(
            child: Text(state.toString(), style: Styles.font13MediumNeonCyan),
          );
        }
      },
    );
  }
}
