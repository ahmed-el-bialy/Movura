import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/video_player.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/common_details_widgets/watchlist_options_sheet.dart';

class ButtonsRow extends StatelessWidget {
  final String? videoKey;

  const ButtonsRow({
    super.key,
    required this.videoKey,
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
                  style: TextStyles.font17BoldTrueBlackSora.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _CircularActionButton(
            icon: Icons.add_rounded,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.transparent,
                builder: (context) => const WatchlistOptionsSheet(),
              );
            },
            color: AppColors.neonBlue,
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  const _CircularActionButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46.r,
      height: 46.r,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(
            width: 1.5.w,
            color: color.withValues(alpha: 0.4),
          ),
          shape: const CircleBorder(),
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          elevation: 0,
        ),
        child: Center(
          child: Icon(
            icon,
            color: color.withValues(alpha: 0.95),
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
