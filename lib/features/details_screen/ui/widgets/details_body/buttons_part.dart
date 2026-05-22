import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/video_helper.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

class ButtonsPart extends StatelessWidget {
  final String? videoKey;

  const ButtonsPart({super.key, required this.videoKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                playVideo(context, videoKey!);
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
                      Icons.play_circle_fill_outlined,
                      color: AppColors.trueBlack,
                      size: 22.sp,
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

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonCyan,
              shape: const CircleBorder(),
              padding: EdgeInsets.all(12.r),

              elevation: 4,
            ),
            child: Icon(Icons.add, color: AppColors.trueBlack, size: 26.sp),
          ),
        ],
      ),
    );
  }
}
