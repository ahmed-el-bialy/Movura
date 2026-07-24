import 'package:flutter/material.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/features/details/data/models/tv_models/season_details_model.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/episode_card.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({
    super.key,
    required this.episodes,
    required this.tvId,
    required this.tvTitle,
    required this.seasonName,
  });

  final List<EpisodeModel> episodes;
  final int tvId;
  final String tvTitle;
  final String seasonName;

  void _openEpisode(BuildContext context, EpisodeModel episode) {
    context.pushNamed(
      RouteNames.episodeDetailsScreen,
      EpisodeArgumentsModel(
        tvId: tvId,
        seasonNumber: episode.seasonNumber,
        episodeNumber: episode.episodeNumber,
        tvTitle: tvTitle,
        seasonName: seasonName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final episode = episodes[index];
          return EpisodeCard(
            episode: episode,
            onTap: () => _openEpisode(context, episode),
          );
        },
        childCount: episodes.length,
      ),
    );
  }
}

