import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

class WatchlistOptionsSheet extends StatelessWidget {
  final PosterModel? posterModel;

  const WatchlistOptionsSheet({super.key, this.posterModel});

  void _toggleState(
    BuildContext context,
    String keyName,
    String label,
    Color color,
  ) {
    if (posterModel != null) {
      sl<LibraryCubit>().toggleCollectionItem(
        poster: posterModel!,
        collectionName: keyName,
      );
    }

    final isCurrentlyIn = posterModel != null
        ? sl<LibraryCubit>().isItemInCollection(posterModel!, keyName)
        : false;
    final isAdded = !isCurrentlyIn;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isAdded ? Icons.check_circle_rounded : Icons.info_outline_rounded,
              color: AppColors.pureWhite,
              size: 20.sp,
            ),
            AppSpacing.horizontalSpacing(AppSpacing.m),
            Text(
              isAdded ? 'Added to $label' : 'Removed from $label',
              style: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                color: AppColors.pureWhite,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
        backgroundColor: isAdded
            ? color.withValues(alpha: 0.95)
            : AppColors.softRed.withValues(alpha: 0.95),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: AppSpacing.all(AppSpacing.l),
        elevation: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          final isFavorite = posterModel != null
              ? sl<LibraryCubit>().isItemInCollection(posterModel!, 'favorites')
              : false;
          final isToWatch = posterModel != null
              ? sl<LibraryCubit>().isItemInCollection(posterModel!, 'toWatch')
              : false;
          final isWatched = posterModel != null
              ? sl<LibraryCubit>().isItemInCollection(posterModel!, 'watched')
              : false;
          final isWatchNow = posterModel != null
              ? sl<LibraryCubit>().isItemInCollection(posterModel!, 'watchNow')
              : false;

          return Container(
            padding: AppSpacing.only(
              left: AppSpacing.xl,
              top: AppSpacing.m,
              right: AppSpacing.xl,
              bottom: AppSpacing.xxl,
            ),
            decoration: BoxDecoration(
              color: AppColors.charcoalBlack,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.trueBlack.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.slateGray.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                AppSpacing.verticalSpacing(AppSpacing.xl),
                Row(
                  children: [
                    Text(
                      'Save to Library',
                      style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                        fontSize: 20.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.coolGray.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalSpacing(AppSpacing.xs),
                Text(
                  'Quickly organize items into your library collections',
                  style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                    color: AppColors.coolGray.withValues(alpha: 0.8),
                  ),
                ),
                AppSpacing.verticalSpacing(AppSpacing.xxl),
                Row(
                  children: [
                    _ActionItem(
                      activeIcon: Icons.favorite_rounded,
                      inactiveIcon: Icons.favorite_border_rounded,
                      label: 'Favorites',
                      isSelected: isFavorite,
                      onTap: () => _toggleState(
                        context,
                        'favorites',
                        'Favorites',
                        AppColors.softRed,
                      ),
                      color: AppColors.softRed,
                    ),
                    _ActionItem(
                      activeIcon: Icons.bookmark_rounded,
                      inactiveIcon: Icons.bookmark_outline_rounded,
                      label: 'To Watch',
                      isSelected: isToWatch,
                      onTap: () => _toggleState(
                        context,
                        'toWatch',
                        'To Watch',
                        AppColors.neonBlue,
                      ),
                      color: AppColors.neonBlue,
                    ),
                    _ActionItem(
                      activeIcon: Icons.check_circle_rounded,
                      inactiveIcon: Icons.check_circle_outline_rounded,
                      label: 'Watched',
                      isSelected: isWatched,
                      onTap: () => _toggleState(
                        context,
                        'watched',
                        'Watched',
                        AppColors.tealCyan,
                      ),
                      color: AppColors.tealCyan,
                    ),
                    _ActionItem(
                      activeIcon: Icons.play_circle_fill_rounded,
                      inactiveIcon: Icons.play_circle_outline_rounded,
                      label: 'Watch It Now',
                      isSelected: isWatchNow,
                      onTap: () => _toggleState(
                        context,
                        'watchNow',
                        'Watch It Now',
                        AppColors.amberGold,
                      ),
                      color: AppColors.amberGold,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionItem extends StatefulWidget {
  const _ActionItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.onTap,
    required this.color,
    required this.isSelected,
  });

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool isSelected;

  @override
  State<_ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<_ActionItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.12,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: AppSpacing.horizontal(AppSpacing.xs),
        child: GestureDetector(
          onTapDown: (_) => _pulseController.forward(),
          onTapUp: (_) => _pulseController.reverse(),
          onTapCancel: () => _pulseController.reverse(),
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _scaleAnim,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnim.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: AppSpacing.vertical(AppSpacing.l),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? widget.color.withValues(alpha: 0.18)
                    : AppColors.onyxBlack.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: widget.isSelected
                      ? widget.color
                      : AppColors.pureWhite.withValues(alpha: 0.05),
                  width: widget.isSelected ? 2.0 : 1.5,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: widget.color.withValues(alpha: 0.35),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.isSelected ? widget.activeIcon : widget.inactiveIcon,
                        color: widget.isSelected
                            ? widget.color
                            : AppColors.coolGray.withValues(alpha: 0.8),
                        size: 24.sp,
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font10BoldCoolGray.copyWith(
                          color: widget.isSelected
                              ? AppColors.pureWhite
                              : AppColors.coolGray.withValues(alpha: 0.6),
                          fontSize: 9.sp,
                          fontWeight: widget.isSelected ? Weights.bold : Weights.medium,
                        ),
                      ),
                    ],
                  ),
                  if (widget.isSelected)
                    Positioned(
                      top: -6.r,
                      right: -4.r,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color,
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withValues(alpha: 0.5),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 10.sp,
                          color: AppColors.trueBlack,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
