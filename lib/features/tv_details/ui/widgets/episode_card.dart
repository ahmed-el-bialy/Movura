import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/date_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/tv_details/data/season_details_model.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode, this.onTap});

  final EpisodeModel episode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasStill = episode.stillPath != null && episode.stillPath!.isNotEmpty;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
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
                              style: TextStyles.font13BoldNeonBlueSora
                                  .copyWith(fontSize: 11.sp),
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
                            horizontalSpacing(4),
                            Text(
                              episode.voteAverage!.toStringAsFixed(1),
                              style: TextStyles.font12CoolGrayManrope
                                  .copyWith(color: AppColors.platinumGray),
                            ),
                          ],
                        ],
                      ),
                      verticalSpacing(8),
                      Text(
                        episode.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font17BoldIceBlueMontserrat
                            .copyWith(fontSize: 14.sp),
                      ),
                      if (episode.overview != null &&
                          episode.overview!.isNotEmpty) ...[
                        verticalSpacing(6),
                        Text(
                          episode.overview!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font12CoolGrayManrope.copyWith(
                            fontSize: 11.sp,
                            height: 1.4,
                          ),
                        ),
                      ],
                      verticalSpacing(8),
                      Row(
                        children: [
                          if (episode.airDate != null &&
                              episode.airDate!.isNotEmpty) ...[
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 12.sp,
                              color: AppColors.coolGray,
                            ),
                            horizontalSpacing(4),
                            Text(
                              episode.airDate!.toTimeAgo().isNotEmpty
                                  ? episode.airDate!.toTimeAgo()
                                  : episode.airDate!,
                              style: TextStyles.font12CoolGrayManrope
                                  .copyWith(fontSize: 10.sp),
                            ),
                          ],
                          if (episode.runtime != null) ...[
                            const Spacer(),
                            Icon(
                              Icons.schedule_rounded,
                              size: 12.sp,
                              color: AppColors.coolGray,
                            ),
                            horizontalSpacing(4),
                            Text(
                              '${episode.runtime} min',
                              style: TextStyles.font12CoolGrayManrope
                                  .copyWith(fontSize: 10.sp),
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
          style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
            fontSize: 28.sp,
            color: AppColors.neonBlue.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
