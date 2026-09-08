import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/shared_details/watchlist_options_sheet.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

import '../../helpers/video_player.dart';
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
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          final isSaved = posterModel != null &&
              (sl<LibraryCubit>().isItemInCollection(posterModel!, 'favorites') ||
                  sl<LibraryCubit>().isItemInCollection(posterModel!, 'toWatch') ||
                  sl<LibraryCubit>().isItemInCollection(posterModel!, 'watched') ||
                  sl<LibraryCubit>().isItemInCollection(posterModel!, 'watchNow'));

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
                  icon: isSaved ? Icons.check_rounded : Icons.add_rounded,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.transparent,
                      builder: (context) =>
                          WatchlistOptionsSheet(posterModel: posterModel),
                    );
                  },
                  color: isSaved ? AppColors.profitGreen : AppColors.neonBlue,
                ),
                AppSpacing.horizontalSpacing(AppSpacing.m),
              ],
            ),
          );
        },
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 46.r,
      height: 46.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.onyxBlack.withValues(alpha: 0.6),
        border: Border.all(
          width: 1.5.w,
          color: color.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                icon,
                key: ValueKey(icon),
                color: color,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
