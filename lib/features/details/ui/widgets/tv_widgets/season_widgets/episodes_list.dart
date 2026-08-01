import 'package:flutter/material.dart';
import 'package:movura/features/details/data/models/tv_models/season_details_model.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/episode_card.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({super.key, required this.episodes});

  final List<EpisodeModel> episodes;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => EpisodeCard(episode: episodes[index]),
        childCount: episodes.length,
      ),
    );
  }
}
