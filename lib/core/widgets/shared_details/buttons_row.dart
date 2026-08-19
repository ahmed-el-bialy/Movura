import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/widgets/shared_details/watchlist_options_sheet.dart';

import '../../helpers/video_player.dart';
import 'package:movura/core/theming/app_colors.dart';
import '../../theming/app_spacing.dart';
import '../../theming/text_styles.dart';

class ButtonsRow extends StatelessWidget {
  final String? videoKey;
  final PosterModel? posterModel;

  const ButtonsRow({
    super.key,
    required this.videoKey,
    this.posterModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(10),
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
          AppSpacing.horizontalSpacing(AppSpacing.m),
          _CircularActionButton(
            icon: Icons.add_rounded,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.transparent,
                builder: (context) => WatchlistOptionsSheet(posterModel: posterModel),
              );
            },
            color: AppColors.neonBlue,
          ),
          AppSpacing.horizontalSpacing(AppSpacing.m),
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
          side: BorderSide(width: 1.5.w, color: color.withValues(alpha: 0.4)),
          shape: const CircleBorder(),
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          elevation: 0,
        ),
        child: Center(
          child: Icon(icon, color: color.withValues(alpha: 0.95), size: 24.sp),
        ),
      ),
    );
  }
}
