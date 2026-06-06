import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/utils/helpers/video_player.dart';

import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/styles.dart';

class ButtonsRow extends StatelessWidget {
  final String? videoKey;

  const ButtonsRow({super.key, required this.videoKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                playYoutubeVideo(context, videoKey!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonCyan,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.trueBlack,
                      size: 24.sp,
                    ),
                    SizedBox(width: 6.w),

                    Text(
                      "WATCH TRAILER",
                      style: Styles.font17BoldTrueBlackSora,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(width: 1.2, color: AppColors.neonCyan),
              shape: const CircleBorder(),
              padding: EdgeInsets.all(11.r),
              elevation: 0,
            ),
            child: Icon(
              Icons.playlist_add,
              color: AppColors.neonCyan,
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }
}
