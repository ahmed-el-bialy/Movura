import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class TrendingBannerItem extends StatelessWidget {
  const TrendingBannerItem({
    super.key,
    required this.poster,
    required this.isActive,
  });

  final PosterModel poster;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final imagePath = poster.posterPath ?? poster.profilePath ?? '';

    return AnimatedScale(
      scale: isActive ? 1.0 : 0.92,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuart,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonBlue.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: '${ApiConstants.imageBaseUrl}$imagePath',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(color: AppColors.onyxBlack),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poster.title ?? poster.name ?? '',
                            style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                              fontSize: 20.sp,
                              shadows: [
                                const Shadow(
                                  color: Colors.black,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpacing(6),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.neonBlue,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  poster.mediaType?.toUpperCase() ?? 'N/A',
                                  style: AppTextStyles.font10BoldCoolGray.copyWith(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                              horizontalSpacing(12),
                              if (poster.voteAverage != null && poster.voteAverage! > 0) ...[
                                Icon(Icons.star_rounded, color: AppColors.gold, size: 18.sp),
                                horizontalSpacing(4),
                                Text(
                                  poster.voteAverage!.toStringAsFixed(1),
                                  style: AppTextStyles.font14BoldIceBlueMontserrat,
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
            ],
          ),
        ),
      ),
    );
  }
}
