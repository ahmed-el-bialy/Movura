import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/utils/helpers/video_player.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class ButtonsRow extends StatelessWidget {
  final String? videoKey;
  final String? homepageUrl;

  const ButtonsRow({
    super.key,
    required this.videoKey,
    this.homepageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [

          Expanded(
            child: SizedBox(
              height: 46.r,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (videoKey != null) {
                    playYoutubeVideo(context, videoKey!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonBlue,
                  foregroundColor: AppColors.trueBlack,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: const Icon(Icons.play_arrow_rounded, size: 24),
                label: Text(
                  "WATCH TRAILER",
                  style: AppTextStyles.font17BoldTrueBlackSora.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),


          SizedBox(
            width: 46.r,
            height: 46.r,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(
                  width: 1.5.w,
                  color: AppColors.neonBlue.withValues(alpha: 0.4),
                ),
                shape: const CircleBorder(),
                backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
                elevation: 0,
              ),
              child:  Center(
                child: Icon(
                  Icons.playlist_add_rounded,
                  color: AppColors.neonBlue,
                  size: 24.sp,
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),


          SizedBox(
            width: 46.r,
            height: 46.r,
            child: OutlinedButton(
              onPressed: () {

              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(
                  width: 1,
                  color: AppColors.coolGray.withValues(alpha: 0.3),
                ),
                shape: const CircleBorder(),
                backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
                elevation: 0,
              ),
              child: Center(
                child: Icon(
                  Icons.open_in_new_rounded,
                  color: AppColors.coolGray.withValues(alpha: 0.95),
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}