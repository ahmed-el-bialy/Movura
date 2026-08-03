import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/tv_details/ui/widgets/seasons_list.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_networks_list.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/models/video_model.dart';
import '../../../../core/networking/di.dart';
import '../../../../core/routing/arguments_models.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/shared_details/actors_list.dart';
import '../../../../core/widgets/shared_details/companies_list.dart';
import '../../../../core/widgets/shared_details/images_list.dart';
import '../../../../core/widgets/shared_details/videos_list.dart';
import '../../data/season_details_model.dart';
import '../../logic/about_tv/about_tv_cubit.dart';
import '../../logic/tv_seasons_cubit/tv_seasons_cubit.dart';

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
            final episodes = state.seasonDetails.episodes;
            final seasonName = state.seasonDetails.name ?? 'Season 1';
            return SizedBox(
              height: 200.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                physics: const BouncingScrollPhysics(),
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return _HorizontalEpisodeCard(
                    episode: episode,
                    onTap: () {
                      context.pushNamed(
                        RouteNames.episodeDetailsScreen,
                        arguments: EpisodeArgumentsModel(
                          tvId: tvId,
                          seasonNumber: seasonNumber,
                          episodeNumber: episode.episodeNumber,
                          tvTitle: tvTitle,
                          seasonName: seasonName,
                          totalEpisodes: episodes.length,
                        ),
                      );
                    },
                  );
                },
              ),
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

class _HorizontalEpisodeCard extends StatelessWidget {
  const _HorizontalEpisodeCard({required this.episode, required this.onTap});

  final EpisodeModel episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: AppColors.onyxBlack,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.neonBlue.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: hasStill
                      ? CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${episode.stillPath}',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.darkBackground,
                            child: Icon(
                              Icons.tv_rounded,
                              color: AppColors.neonBlue.withValues(alpha: 0.4),
                              size: 32.sp,
                            ),
                          ),
                        )
                      : Container(
                          color: AppColors.darkBackground,
                          child: Icon(
                            Icons.tv_rounded,
                            color: AppColors.neonBlue.withValues(alpha: 0.4),
                            size: 32.sp,
                          ),
                        ),
                ),
                Positioned(
                  top: 6.h,
                  left: 6.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neonBlue.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'E${episode.episodeNumber}',
                      style: TextStyle(
                        color: AppColors.trueBlack,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                if (episode.voteAverage != null && episode.voteAverage! > 0)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.trueBlack.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 10.sp,
                          ),
                          horizontalSpacing(2),
                          Text(
                            episode.voteAverage!.toStringAsFixed(1),
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            // Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font12CoolGrayManrope.copyWith(
                        color: AppColors.iceBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.sp,
                        height: 1.3,
                      ),
                    ),
                    if (episode.runtime != null) ...[
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 10.sp,
                            color: AppColors.coolGray,
                          ),
                          horizontalSpacing(3),
                          Text(
                            '${episode.runtime} min',
                            style: TextStyles.font12CoolGrayManrope.copyWith(
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
