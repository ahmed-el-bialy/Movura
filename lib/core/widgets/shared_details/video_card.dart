import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/video_player.dart';
import '../../models/video_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import '../../theming/app_spacing.dart';
import '../../theming/text_styles.dart';
import '../../theming/weights.dart';
import '../loading/movura_loading_indicator.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.video,
    required this.youtubeThumbnail,
  });

  final VideoModel video;
  final String youtubeThumbnail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.only(
        right: AppSpacing.l,
        bottom: AppSpacing.s,
        top: AppSpacing.xs,
      ),
      child: GestureDetector(
        onTap: () {
          if (video.key != null) playYoutubeVideo(context, video.key!);
        },
        child: Container(
          width: 180.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  width: 180.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  imageUrl: youtubeThumbnail,
                  placeholder: (context, url) => Container(
                    width: 180.w,
                    color: AppColors.jetBlack,
                    child: const Center(
                      child: MovuraLoadingIndicator(size: 35),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.onyxBlack,
                    child: const Icon(
                      Icons.play_circle_outline,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
              ),
              Container(
                width: 180.w,
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.transparent,
                      AppColors.trueBlack.withValues(alpha: 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              Center(
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: AppColors.neonBlue.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonBlue.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.trueBlack,
                    size: 20.sp,
                  ),
                ),
              ),
              Positioned(
                bottom: 8.h,
                left: 8.w,
                right: 8.w,
                child: Text(
                  video.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 10.sp,
                    fontWeight: Weights.semiBold,
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
