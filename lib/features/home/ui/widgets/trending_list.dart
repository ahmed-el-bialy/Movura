import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/skeleton_posters_list_loading.dart';
import 'package:movura/features/home/ui/widgets/trending_poster_list.dart';

import '../../../../core/theming/text_styles.dart';
import '../../logic/trending_content/trending_content_cubit.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingContentCubit, TrendingContentState>(
      builder: (context, state) {
        if (state is TrendingContentLoading) {
          return SliverToBoxAdapter(child: SkeletonPostersListLoading());
        } else if (state is TrendingContentLoaded) {
          return SliverToBoxAdapter(
            child: TrendingPosterList(trendingContent: state.posters),
          );
        } else if (state is TrendingContentFailed) {
          return SliverToBoxAdapter(
            child: Text(state.errorMessage, style: AppTextStyles.font13MediumNeonBlue),
          );
        } else {
          return SliverToBoxAdapter(
            child: Text(state.toString(), style: AppTextStyles.font13MediumNeonBlue),
          );
        }
      },
    );
  }
}
