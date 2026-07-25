import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/section_title.dart';

import '../../../../../core/widgets/shared_details/actors_list.dart';
import '../../../../../core/widgets/shared_details/videos_list.dart';
import '../../../data/episode_details_model.dart';
import '../sub_widgets/episode_navigation_button.dart';

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
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        AppColors.richEerieBlack,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
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
                            style: AppTextStyles.font12CoolGrayManrope,
                          ),
                          verticalSpacing(4),
                          Text(
                            episode.name ?? 'Episode',
                            style: AppTextStyles.font17BoldIceBlueMontserrat
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
        if (episode.overview != null && episode.overview!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(sectionName: 'STORYLINE'),
                  verticalSpacing(8),
                  Text(
                    episode.overview!,
                    style: AppTextStyles.font12CoolGrayManrope.copyWith(
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (episode.guestStars != null && episode.guestStars!.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'GUEST STARS'),
                ActorsList(actors: episode.guestStars!),
              ],
            ),
          ),
        if (episode.videos?.videoList != null &&
            episode.videos!.videoList!.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionName: 'VIDEOS'),
                VideosList(allVideos: episode.videos!.videoList!),
              ],
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
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
                if (hasPrevious && hasNext) horizontalSpacing(12),
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
        sliverVerticalSpacing(90),
      ],
    );
  }
}
