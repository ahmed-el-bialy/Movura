import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/details/data/models/tv_models/season_details_model.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/season_widgets/episodes_list.dart';

class TvSeasonDetailsBody extends StatelessWidget {
  const TvSeasonDetailsBody({
    super.key,
    required this.seasonDetails,
    required this.tvTitle,
    required this.tvId,
  });

  final SeasonDetailsModel seasonDetails;
  final String tvTitle;
  final int tvId;

  @override
  Widget build(BuildContext context) {
    final hasPoster =
        seasonDetails.posterPath != null && seasonDetails.posterPath!.isNotEmpty;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ─── Collapsible header with poster ───────────────────────────────────
        SliverAppBar(
          expandedHeight: 340.h,
          pinned: true,
          floating: false,
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
                onTap: () => context.popToHomeOrGoHome(),
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
                // Backdrop / poster image
                hasPoster
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${seasonDetails.posterPath}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Container(color: AppColors.onyxBlack),
                      )
                    : Container(color: AppColors.onyxBlack),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.6),
                        AppColors.richEerieBlack,
                      ],
                    ),
                  ),
                ),

                // Identity card at bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
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
                              color: AppColors.pureWhite.withValues(alpha: 0.15),
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
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpacing(4),
                              Text(
                                seasonDetails.name ?? 'Season',
                                style: AppTextStyles.font17BoldIceBlueMontserrat
                                    .copyWith(fontSize: 20.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (seasonDetails.airDate != null &&
                                  seasonDetails.airDate!.isNotEmpty) ...[
                                verticalSpacing(6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 13.sp,
                                      color: AppColors.coolGray,
                                    ),
                                    horizontalSpacing(5),
                                    Text(
                                      seasonDetails.airDate!,
                                      style: AppTextStyles.font10MediumCoolGraySora
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.tv_rounded,
                                      size: 13.sp,
                                      color: AppColors.coolGray,
                                    ),
                                    horizontalSpacing(5),
                                    Text(
                                      '${seasonDetails.episodes.length} Episodes',
                                      style: AppTextStyles.font10MediumCoolGraySora
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ],
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

        // ─── Season overview ───────────────────────────────────────────────────
        if (seasonDetails.overview != null &&
            seasonDetails.overview!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                seasonDetails.overview!,
                style: AppTextStyles.font12CoolGrayManrope.copyWith(
                  height: 1.6,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),

        sliverVerticalSpacing(4),

        // ─── Episodes header ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.neonBlue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                horizontalSpacing(10),
                Text(
                  'Episodes',
                  style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                horizontalSpacing(8),
                Text(
                  '(${seasonDetails.episodes.length})',
                  style: AppTextStyles.font12CoolGrayManrope,
                ),
              ],
            ),
          ),
        ),

        sliverVerticalSpacing(12),

        EpisodesList(
          episodes: seasonDetails.episodes,
          tvId: tvId,
          tvTitle: tvTitle,
          seasonName: seasonDetails.name ?? 'Season',
        ),

        sliverVerticalSpacing(40),
      ],
    );
  }
}
