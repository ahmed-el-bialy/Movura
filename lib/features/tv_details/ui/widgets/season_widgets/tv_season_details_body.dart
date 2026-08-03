import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

import '../../../data/season_details_model.dart';
import 'episodes_list.dart';

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
        seasonDetails.posterPath != null &&
        seasonDetails.posterPath!.isNotEmpty;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 340.h,
          pinned: true,
          backgroundColor: AppColors.eerieBlack,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.neonBlue,
              size: 20.sp,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Stack(
              fit: StackFit.expand,
              children: [
                hasPoster
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${seasonDetails.posterPath}',
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
                            style: TextStyles.font12RegularCoolGrayManrope,
                          ),
                          AppSpacing.verticalSpacing(AppSpacing.xs),
                          Text(
                            seasonDetails.name ?? 'Season',
                            style: TextStyles.font17BoldIceBlueMontserrat
                                .copyWith(fontSize: 20.sp),
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
        if (seasonDetails.overview != null &&
            (seasonDetails.overview?.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                seasonDetails.overview ?? '',
                style: TextStyles.font12RegularCoolGrayManrope.copyWith(height: 1.6),
              ),
            ),
          ),
        AppSpacing.sliverVerticalSpacing(AppSpacing.l),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Episodes',
              style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                fontWeight: Weights.bold,
              ),
            ),
          ),
        ),
        AppSpacing.sliverVerticalSpacing(AppSpacing.m),
        EpisodesList(
          episodes: seasonDetails.episodes,
          tvId: tvId,
          tvTitle: tvTitle,
          seasonName: seasonDetails.name ?? 'Season',
        ),
        AppSpacing.sliverVerticalSpacing(40),
      ],
    );
  }
}
