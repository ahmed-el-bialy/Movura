import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/video_player.dart';
import 'package:movura/core/models/video_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

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
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () {
          playYoutubeVideo(context, video.key);
        },
        child: Card(
          elevation: 5,
          shadowColor: AppColors.neonBlue,
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: 190.w,
                  height: 115.h,
                  fit: BoxFit.cover,
                  imageUrl: youtubeThumbnail,
                  placeholder: (context, url) => Container(
                    width: 190.w,
                    color: AppColors.jetBlack,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                width: 190.w,
                height: 115.h,
                decoration: BoxDecoration(
                  color: AppColors.trueBlack.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.neonBlue,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.trueBlack,
                  size: 26,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  video.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font11BoldIceBlueMontserrat.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 11.sp,
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
