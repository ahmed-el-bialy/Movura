import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/di.dart';
import '../../../../core/routing/arguments_models.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_navigation_bar.dart';
import '../../../../core/widgets/shared_details/episode_loading_skeleton.dart';
import '../../logic/episodes/tv_episode_details_cubit.dart';
import '../widgets/episode_widgets/episode_details_body.dart';

class EpisodeDetailsScreen extends StatelessWidget {
  const EpisodeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EpisodeArgumentsModel;

    return BlocProvider(
      create: (context) => sl<TvEpisodeDetailsCubit>()
        ..getTvEpisodeDetails(
          tvId: args.tvId,
          seasonNumber: args.seasonNumber,
          episodeNumber: args.episodeNumber,
        ),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        extendBody: true,
        body: BlocBuilder<TvEpisodeDetailsCubit, TvEpisodeDetailsState>(
          builder: (context, state) {
            if (state is TvEpisodeDetailsLoading) {
              return const EpisodeLoadingSkeleton();
            }

            if (state is TvEpisodeDetailsLoaded) {
              return EpisodeDetailsBody(
                episode: state.episodeDetails,
                tvTitle: args.tvTitle,
                seasonName: args.seasonName,
                tvId: args.tvId,
                totalEpisodes: args.totalEpisodes,
              );
            }

            if (state is TvEpisodeDetailsError) {
              return AppErrorWidget(
                errorMessage: state.errorMessage,
                onRetry: () =>
                    context.read<TvEpisodeDetailsCubit>().getTvEpisodeDetails(
                      tvId: args.tvId,
                      seasonNumber: args.seasonNumber,
                      episodeNumber: args.episodeNumber,
                    ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
      ),
    );
  }
}
