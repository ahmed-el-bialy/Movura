import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/core/widgets/shared_details/actors_list.dart';
import 'package:movura/core/widgets/shared_details/images_list.dart';
import 'package:movura/core/widgets/shared_details/videos_list.dart';

import '../../../../../core/theming/app_spacing.dart';
import '../../../data/episode_details_model.dart';
import '../tv_info_widgets/episode_navigation_button.dart';

class EpisodeDetailsBody extends StatelessWidget {
  const EpisodeDetailsBody({
    super.key,
    required this.episode,
    required this.tvTitle,
    required this.seasonName,
    required this.tvId,
    this.totalEpisodes,
  });

  final EpisodeDetailsModel episode;
  final String tvTitle;
  final String seasonName;
  final int tvId;
  final int? totalEpisodes;

  void _navigateToEpisode(BuildContext context, int episodeNumber) {
    context.pushReplacementNamed(
      RouteNames.episodeDetailsScreen,
      arguments: EpisodeArgumentsModel(
        tvId: tvId,
        seasonNumber: episode.seasonNumber,
        episodeNumber: episodeNumber,
        tvTitle: tvTitle,
        seasonName: seasonName,
        totalEpisodes: totalEpisodes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;
    final hasNext =
        totalEpisodes != null && episode.episodeNumber < totalEpisodes!;
    final hasPrevious = episode.episodeNumber > 1;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 320.h,
          pinned: true,
          backgroundColor: AppColors.eerieBlack,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.neonBlue,
              size: 18.r,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Stack(
              fit: StackFit.expand,
              children: [
                hasStill
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${episode.stillPath}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Container(color: AppColors.onyxBlack),
                      )
                    : Container(color: AppColors.onyxBlack),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.transparent,
                        AppColors.trueBlack.withValues(alpha: 0.2),
                        AppColors.richEerieBlack,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: AppSpacing.all(AppSpacing.l),
                    child: Container(
                      width: double.infinity,
                      padding: AppSpacing.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.pureWhite.withValues(alpha: 0.07),
                        border: Border.all(
                          color: AppColors.pureWhite.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvTitle,
                            style: TextStyles.font12RegularCoolGrayManrope,
                          ),
                          AppSpacing.verticalSpacing(AppSpacing.xs),
                          Text(
                            episode.name ?? 'Episode',
                            style: TextStyles.font17BoldIceBlueMontserrat
                                .copyWith(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (episode.overview != null && (episode.overview?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(sectionName: 'STORYLINE'),
                  AppSpacing.verticalSpacing(AppSpacing.s),
                  Text(
                    episode.overview ?? '',
                    style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (episode.guestStars != null &&
            (episode.guestStars?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'GUEST STARS'),
                ActorsList(actors: episode.guestStars ?? []),
              ],
            ),
          ),
        if (episode.crew != null && (episode.crew?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'CREW'),
                ActorsList(actors: episode.crew ?? []),
              ],
            ),
          ),
        if (episode.videos?.videoList != null &&
            (episode.videos?.videoList?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'VIDEOS'),
                VideosList(allVideos: episode.videos?.videoList ?? []),
              ],
            ),
          ),
        if (episode.images?.stills != null &&
            (episode.images?.stills?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'EPISODE STILLS'),
                ImagesList(images: episode.images?.stills ?? []),
              ],
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacing.symmetric(horizontal: AppSpacing.l, vertical: 30),
            child: Row(
              children: [
                if (hasPrevious)
                  Expanded(
                    child: EpisodeNavigationButton(
                      label: 'Previous',
                      icon: Icons.skip_previous_rounded,
                      onTap: () => _navigateToEpisode(
                        context,
                        episode.episodeNumber - 1,
                      ),
                      isLeft: true,
                    ),
                  ),
                if (hasPrevious && hasNext)
                  AppSpacing.horizontalSpacing(AppSpacing.m),
                if (hasNext)
                  Expanded(
                    child: EpisodeNavigationButton(
                      label: 'Next',
                      icon: Icons.skip_next_rounded,
                      onTap: () => _navigateToEpisode(
                        context,
                        episode.episodeNumber + 1,
                      ),
                      isLeft: false,
                    ),
                  ),
              ],
            ),
          ),
        ),
        AppSpacing.sliverVerticalSpacing(90),
      ],
    );
  }
}
