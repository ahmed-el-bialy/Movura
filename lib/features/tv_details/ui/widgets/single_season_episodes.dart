import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/features/tv_details/data/season_details_model.dart';
import 'package:movura/features/tv_details/logic/seasons/tv_seasons_cubit.dart';

class SingleSeasonEpisodes extends StatelessWidget {
  const SingleSeasonEpisodes({
    super.key,
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
            return const Center(child: MovuraLoadingIndicator(size: 60));
          } else if (state is TvSeasonsLoaded) {
            final episodes = state.seasonDetails.episodes;
            final seasonName = state.seasonDetails.name ?? 'Season 1';
            return SizedBox(
              height: 200.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.horizontal(12),
                physics: const BouncingScrollPhysics(),
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return HorizontalEpisodeCard(
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
          return const AppErrorWidget(errorMessage: 'Something went wrong');
        },
      ),
    );
  }
}

class HorizontalEpisodeCard extends StatelessWidget {
  const HorizontalEpisodeCard({
    super.key,
    required this.episode,
    required this.onTap,
  });

  final EpisodeModel episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,
        margin: AppSpacing.only(right: AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.onyxBlack,
          borderRadius: BorderRadius.circular(AppSpacing.l),
          border: Border.all(
            color: AppColors.neonBlue.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: AppSpacing.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neonBlue.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'E${episode.episodeNumber}',
                      style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                        color: AppColors.trueBlack,
                        fontSize: 10.sp,
                        fontWeight: Weights.extraBold,
                      ),
                    ),
                  ),
                ),
                if (episode.voteAverage != null && episode.voteAverage! > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: AppSpacing.symmetric(
                        horizontal: 5,
                        vertical: 2,
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
                          AppSpacing.horizontalSpacing(2),
                          Text(
                            episode.voteAverage!.toStringAsFixed(1),
                            style: TextStyles.font12RegularCoolGrayManrope
                                .copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 9.sp,
                              fontWeight: Weights.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: AppSpacing.all(AppSpacing.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                        color: AppColors.iceBlue,
                        fontWeight: Weights.bold,
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
                          AppSpacing.horizontalSpacing(3),
                          Text(
                            '${episode.runtime} min',
                            style: TextStyles.font12RegularCoolGrayManrope
                                .copyWith(
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
