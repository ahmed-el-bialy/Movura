import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/video_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/core/widgets/shared_details/actors_list.dart';
import 'package:movura/core/widgets/shared_details/companies_list.dart';
import 'package:movura/core/widgets/shared_details/images_list.dart';
import 'package:movura/core/widgets/shared_details/videos_list.dart';
import 'package:movura/features/tv_details/logic/about_tv/about_tv_cubit.dart';
import 'package:movura/features/tv_details/logic/tv_seasons_cubit/tv_seasons_cubit.dart';
import 'package:movura/features/tv_details/ui/widgets/episode_card.dart';
import 'package:movura/features/tv_details/ui/widgets/seasons_list.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_network_card.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_networks_list.dart';

class AboutTvTabBody extends StatelessWidget {
  const AboutTvTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutTvCubit, AboutTvState>(
      builder: (context, state) {
        if (state is AboutTvLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.neonBlue),
          );
        } else if (state is AboutTvLoaded) {
          final List<VideoModel> allVideos =
              state.model.tvVideos?.videoList ?? [];
          final bool hasMultipleSeasons =
              state.model.seasons != null && state.model.seasons!.length > 1;
          final bool hasOneSeason =
              state.model.seasons != null && state.model.seasons!.length == 1;

          return Column(
            children: [
              if (hasMultipleSeasons) ...[
                SectionTitle(
                  sectionName: "Seasons",
                  actionName: AppConstants.sectionAction,
                  onTap: () {
                    context.pushNamed(
                      RouteNames.allSeasonsScreen,
                      arguments: AllSeasonsArgumentsModel(
                        tvId: state.model.id,
                        tvTitle: state.model.title ?? 'TV Show',
                        seasons: state.model.seasons ?? [],
                      ),
                    );
                  },
                ),
                SeasonsList(
                  seasons: state.model.seasons ?? [],
                  tvId: state.model.id,
                  tvTitle: state.model.title ?? 'TV Show',
                ),
                verticalSpacing(15),
              ],
              if (hasOneSeason) ...[
                const SectionTitle(sectionName: "Episodes"),
                verticalSpacing(8),
                _SingleSeasonEpisodes(
                  tvId: state.model.id,
                  tvTitle: state.model.title ?? 'TV Show',
                  seasonNumber: state.model.seasons?.first.seasonNumber ?? 1,
                ),
                verticalSpacing(15),
              ],
              (state.model.actors?.tvActors != null &&
                      state.model.actors!.tvActors!.isNotEmpty)
                  ? SectionTitle(
                      sectionName: "CAST",
                      actionName: AppConstants.sectionAction,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
              if (state.model.actors?.tvActors != null)
                ActorsList(actors: state.model.actors?.tvActors ?? []),
              verticalSpacing(15),
              (state.model.companies != null &&
                      state.model.companies!.isNotEmpty)
                  ? const SectionTitle(sectionName: "Companies")
                  : const SizedBox.shrink(),
              if (state.model.companies != null)
                CompaniesList(company: state.model.companies ?? []),
              verticalSpacing(15),
              (state.model.networks != null && state.model.networks!.isNotEmpty)
                  ? const SectionTitle(sectionName: "Networks")
                  : const SizedBox.shrink(),
              if (state.model.networks != null)
                TvNetworksList(network: state.model.networks ?? []),
              verticalSpacing(15),
              state.model.mediaImages?.backdropImages != null &&
                      state.model.mediaImages!.backdropImages!.isNotEmpty
                  ? const SectionTitle(sectionName: "IMAGES")
                  : const SizedBox.shrink(),
              if (state.model.mediaImages?.backdropImages != null)
                ImagesList(
                  images: state.model.mediaImages?.backdropImages ?? [],
                  height: 250,
                  imageFit: BoxFit.fill,
                ),
              verticalSpacing(15),
              state.model.mediaImages?.logoImages != null &&
                      state.model.mediaImages!.logoImages!.isNotEmpty
                  ? const SectionTitle(sectionName: "LOGOS")
                  : const SizedBox.shrink(),
              if (state.model.mediaImages?.logoImages != null)
                ImagesList(
                  images: state.model.mediaImages?.logoImages ?? [],
                  imageFit: BoxFit.contain,
                  herPadding: 8,
                  imageWidth: 120,
                  height: 180,
                ),
              if (allVideos.isNotEmpty) ...[
                verticalSpacing(15),
                const SectionTitle(sectionName: "TRAILERS & CLIPS"),
                verticalSpacing(8),
                VideosList(allVideos: allVideos),
                verticalSpacing(35),
              ],
            ],
          );
        } else if (state is AboutTvError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {},
          );
        } else {
          return const AppErrorWidget(errorMessage: "There was An Error");
        }
      },
    );
  }
}

class _SingleSeasonEpisodes extends StatelessWidget {
  const _SingleSeasonEpisodes({
    required this.tvId,
    required this.tvTitle,
    required this.seasonNumber,
  });

  final int tvId;
  final String tvTitle;
  final int seasonNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TvSeasonsCubit>()
            ..getTvSeasonDetails(tvId: tvId, seasonNumber: seasonNumber),
      child: BlocBuilder<TvSeasonsCubit, TvSeasonsState>(
        builder: (context, state) {
          if (state is TvSeasonsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvSeasonsLoaded) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.seasonDetails.episodes.length,
                  itemBuilder: (context, index) {
                    final episode = state.seasonDetails.episodes[index];
                    return EpisodeCard(
                      episode: episode,
                      onTap: () {
                        context.pushNamed(
                          RouteNames.episodeDetailsScreen,
                          arguments: EpisodeArgumentsModel(
                            tvId: tvId,
                            seasonNumber: seasonNumber,
                            episodeNumber: episode.episodeNumber,
                            tvTitle: tvTitle,
                            seasonName: state.seasonDetails.name ?? 'Season 1',
                            totalEpisodes: state.seasonDetails.episodes.length,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          } else if (state is TvSeasonsError) {
            return AppErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => context.read<TvSeasonsCubit>().getTvSeasonDetails(
                tvId: tvId,
                seasonNumber: seasonNumber,
              ),
            );
          }
          return const AppErrorWidget(errorMessage: "Something went wrong");
        },
      ),
    );
  }
}
