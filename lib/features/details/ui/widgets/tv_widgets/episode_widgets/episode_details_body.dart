import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details/data/models/tv_models/episode_details_model.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/actors_list.dart';

class EpisodeDetailsBody extends StatelessWidget {
  const EpisodeDetailsBody({
    super.key,
    required this.episode,
    required this.tvTitle,
    required this.seasonName,
  });

  final EpisodeDetailsModel episode;
  final String tvTitle;
  final String seasonName;

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 320.h,
          pinned: true,
          backgroundColor: AppColors.eerieBlack,
          elevation: 0,
          leading: SizedBox(
            width: 44.r,
            height: 44.r,
            child: Card(
              margin: EdgeInsets.all(6.r),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),
              ),
              color: AppColors.onyxBlack.withValues(alpha: .9),
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                splashColor: AppColors.neonBlue.withValues(alpha: .4),
                onTap: () => context.pop(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.neonBlue,
                      size: 18.r,
                    ),
                  ),
                ),
              ),
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
                        Colors.black.withValues(alpha: 0.7),
                        AppColors.richEerieBlack,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.pureWhite.withValues(alpha: 0.07),
                            border: Border.all(
                              color: AppColors.pureWhite.withValues(
                                alpha: 0.15,
                              ),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tvTitle,
                                style: AppTextStyles.font12CoolGrayManrope,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpacing(4),
                              Text(
                                seasonName,
                                style: AppTextStyles.font10MediumCoolGraySora
                                    .copyWith(fontSize: 11.sp),
                              ),
                              verticalSpacing(8),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.neonBlue.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: AppColors.neonBlue.withValues(
                                          alpha: 0.4,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'S${episode.seasonNumber} E${episode.episodeNumber}',
                                      style: AppTextStyles.font13BoldNeonBlueSora
                                          .copyWith(fontSize: 11.sp),
                                    ),
                                  ),
                                  const Spacer(),
                                  if (episode.voteAverage != null &&
                                      episode.voteAverage! > 0) ...[
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.gold,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      episode.voteAverage!.toStringAsFixed(1),
                                      style: AppTextStyles
                                          .font14BoldIceBlueMontserrat
                                          .copyWith(fontSize: 14.sp),
                                    ),
                                  ],
                                ],
                              ),
                              verticalSpacing(8),
                              Text(
                                episode.name,
                                style: AppTextStyles.font17BoldIceBlueMontserrat
                                    .copyWith(fontSize: 18.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpacing(6),
                              Row(
                                children: [
                                  if (episode.airDate != null &&
                                      episode.airDate!.isNotEmpty) ...[
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 12.sp,
                                      color: AppColors.coolGray,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      episode.airDate!,
                                      style: AppTextStyles.font12CoolGrayManrope
                                          .copyWith(fontSize: 11.sp),
                                    ),
                                  ],
                                  if (episode.runtime != null) ...[
                                    const Spacer(),
                                    Icon(
                                      Icons.schedule_rounded,
                                      size: 12.sp,
                                      color: AppColors.coolGray,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${episode.runtime} min',
                                      style: AppTextStyles.font12CoolGrayManrope
                                          .copyWith(fontSize: 11.sp),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(sectionName: 'STORYLINE'),
                  verticalSpacing(8),
                  Text(
                    episode.overview!,
                    style: AppTextStyles.font12CoolGrayManrope.copyWith(
                      height: 1.6,
                      fontSize: 13.sp,
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
                verticalSpacing(15),
                const SectionTitle(sectionName: 'GUEST STARS'),
                verticalSpacing(8),
                ActorsList(actors: episode.guestStars!),
              ],
            ),
          ),
        if (episode.crew != null && episode.crew!.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(15),
                const SectionTitle(sectionName: 'CREW'),
                verticalSpacing(8),
                ActorsList(actors: episode.crew!),
              ],
            ),
          ),
        SliverToBoxAdapter(child: verticalSpacing(90)),
      ],
    );
  }
}
