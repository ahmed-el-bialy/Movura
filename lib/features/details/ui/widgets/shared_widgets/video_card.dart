import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/video_model.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/helpers/video_player.dart';

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
                    color: Colors.grey[900],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                width: 190.w,
                height: 115.h,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.cyanAccent,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
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
