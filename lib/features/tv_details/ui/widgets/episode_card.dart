import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/date_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

import '../../data/season_details_model.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode, this.onTap});

  final EpisodeModel episode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;

    return Card(
      margin: AppSpacing.symmetric(horizontal: AppSpacing.m, vertical: 6),
      color: AppColors.darkBackground,
      elevation: 4,
      shadowColor: AppColors.neonBlue.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 130.w,
                child: hasStill
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${episode.stillPath}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            _EpisodePlaceholder(
                              episodeNumber: episode.episodeNumber,
                            ),
                      )
                    : _EpisodePlaceholder(episodeNumber: episode.episodeNumber),
              ),
              Expanded(
                child: Padding(
                  padding: AppSpacing.all(AppSpacing.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: AppSpacing.symmetric(
                              horizontal: AppSpacing.s,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.neonBlue.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.neonBlue.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                            child: Text(
                              'E${episode.episodeNumber}',
                              style: TextStyles.font13BoldNeonBlueSora.copyWith(
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (episode.voteAverage != null &&
                              episode.voteAverage! > 0) ...[
                            Icon(
                              Icons.star_rounded,
                              color: AppColors.gold,
                              size: 14.sp,
                            ),
                            AppSpacing.horizontalSpacing(AppSpacing.xs),
                            Text(
                              episode.voteAverage!.toStringAsFixed(1),
                              style: TextStyles.font12RegularCoolGrayManrope
                                  .copyWith(
                                color: AppColors.platinumGray,
                              ),
                            ),
                          ],
                        ],
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      Text(
                        episode.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      if (episode.overview != null &&
                          (episode.overview?.isNotEmpty ?? false)) ...[
                        AppSpacing.verticalSpacing(6),
                        Text(
                          episode.overview ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font12RegularCoolGrayManrope
                              .copyWith(
                            fontSize: 11.sp,
                            height: 1.4,
                          ),
                        ),
                      ],
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      Row(
                        children: [
                          if (episode.airDate != null &&
                              (episode.airDate?.isNotEmpty ?? false)) ...[
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 12.sp,
                              color: AppColors.coolGray,
                            ),
                            AppSpacing.horizontalSpacing(AppSpacing.xs),
                            Text(
                              (episode.airDate?.toTimeAgo().isNotEmpty ?? false)
                                  ? episode.airDate!.toTimeAgo()
                                  : (episode.airDate ?? ""),
                              style: TextStyles.font12RegularCoolGrayManrope
                                  .copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                          if (episode.runtime != null) ...[
                            const Spacer(),
                            Icon(
                              Icons.schedule_rounded,
                              size: 12.sp,
                              color: AppColors.coolGray,
                            ),
                            AppSpacing.horizontalSpacing(AppSpacing.xs),
                            Text(
                              '${episode.runtime} min',
                              style: TextStyles.font12RegularCoolGrayManrope
                                  .copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EpisodePlaceholder extends StatelessWidget {
  const _EpisodePlaceholder({required this.episodeNumber});

  final int episodeNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onyxBlack,
      child: Center(
        child: Text(
          '$episodeNumber',
          style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
            fontSize: 28.sp,
            color: AppColors.neonBlue.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
