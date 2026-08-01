import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/models/video_model.dart';
import 'package:movura/core/widgets/shared_details/video_card.dart';

class VideosList extends StatelessWidget {
  const VideosList({super.key, required this.allVideos});

  final List<VideoModel> allVideos;

  @override
  Widget build(BuildContext context) {
    if (allVideos.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: allVideos.length,
        itemBuilder: (context, index) {
          final video = allVideos[index];
          final youtubeThumbnail =
              "${ApiConstants.videoCoverBaseUrl}${video.key}/0.jpg";
          return VideoCard(
            video: video,
            youtubeThumbnail: youtubeThumbnail,
          );
        },
      ),
    );
  }
}
