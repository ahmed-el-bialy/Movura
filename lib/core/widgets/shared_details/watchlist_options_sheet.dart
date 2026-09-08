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

/// Bottom sheet for saving a poster to library collections.
/// Shows a vertical list of 4 options — each with its own
/// loading → checkmark toggle animation after Firestore confirms.
class WatchlistOptionsSheet extends StatefulWidget {
  final PosterModel? posterModel;

  const WatchlistOptionsSheet({super.key, this.posterModel});

  @override
  State<WatchlistOptionsSheet> createState() => _WatchlistOptionsSheetState();
}

class _WatchlistOptionsSheetState extends State<WatchlistOptionsSheet> {
  // Tracks which collections are currently doing a Firestore round-trip
  final Set<String> _loadingKeys = {};

  Future<void> _toggle(BuildContext context, String key) async {
    if (_loadingKeys.contains(key)) return; // debounce rapid taps
    setState(() => _loadingKeys.add(key));

    try {
      await context.read<LibraryCubit>().toggleCollectionItem(
        poster: widget.posterModel!,
        collectionName: key,
      );
    } finally {
      if (mounted) setState(() => _loadingKeys.remove(key));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          bool isIn(String key) {
            if (widget.posterModel == null) return false;
            return context
                .read<LibraryCubit>()
                .isItemInCollection(widget.posterModel!, key);
          }

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
                  blurRadius: 24,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.slateGray.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                AppSpacing.verticalSpacing(AppSpacing.xl),

                // Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Save to Library',
                            style: TextStyles.font17BoldIceBlueMontserrat
                                .copyWith(fontSize: 19.sp, letterSpacing: 0.3),
                          ),
                          AppSpacing.verticalSpacing(AppSpacing.xs),
                          Text(
                            'Tap a collection to add or remove',
                            style: TextStyles.font12RegularCoolGrayManrope
                                .copyWith(
                                  color: AppColors.coolGray.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.coolGray.withValues(alpha: 0.5),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),

                AppSpacing.verticalSpacing(AppSpacing.xl),

                // Collection rows
                _CollectionRow(
                  activeIcon: Icons.favorite_rounded,
                  inactiveIcon: Icons.favorite_border_rounded,
                  label: 'Favorites',
                  subtitle: 'Your all-time favorites',
                  isSelected: isIn('favorites'),
                  isLoading: _loadingKeys.contains('favorites'),
                  color: AppColors.softRed,
                  onTap: widget.posterModel != null
                      ? () => _toggle(context, 'favorites')
                      : null,
                ),
                _CollectionRow(
                  activeIcon: Icons.bookmark_rounded,
                  inactiveIcon: Icons.bookmark_outline_rounded,
                  label: 'To Watch',
                  subtitle: 'Films & shows you plan to watch',
                  isSelected: isIn('toWatch'),
                  isLoading: _loadingKeys.contains('toWatch'),
                  color: AppColors.neonBlue,
                  onTap: widget.posterModel != null
                      ? () => _toggle(context, 'toWatch')
                      : null,
                ),
                _CollectionRow(
                  activeIcon: Icons.check_circle_rounded,
                  inactiveIcon: Icons.check_circle_outline_rounded,
                  label: 'Watched',
                  subtitle: 'Already seen it',
                  isSelected: isIn('watched'),
                  isLoading: _loadingKeys.contains('watched'),
                  color: AppColors.tealCyan,
                  onTap: widget.posterModel != null
                      ? () => _toggle(context, 'watched')
                      : null,
                ),
                _CollectionRow(
                  activeIcon: Icons.play_circle_fill_rounded,
                  inactiveIcon: Icons.play_circle_outline_rounded,
                  label: 'Watch It Now',
                  subtitle: 'Currently watching',
                  isSelected: isIn('watchNow'),
                  isLoading: _loadingKeys.contains('watchNow'),
                  color: AppColors.amberGold,
                  onTap: widget.posterModel != null
                      ? () => _toggle(context, 'watchNow')
                      : null,
                  isLast: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// One row in the watchlist sheet — icon, label, subtitle, and right-side toggle.
class _CollectionRow extends StatelessWidget {
  const _CollectionRow({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.isLoading,
    required this.color,
    required this.onTap,
    this.isLast = false,
  });

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final String subtitle;
  final bool isSelected;
  final bool isLoading;
  final Color color;
  final VoidCallback? onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            splashColor: color.withValues(alpha: 0.08),
            highlightColor: color.withValues(alpha: 0.04),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              padding: AppSpacing.symmetric(horizontal: 4, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: isSelected
                    ? color.withValues(alpha: 0.06)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  // Left icon container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? color.withValues(alpha: 0.18)
                          : AppColors.onyxBlack.withValues(alpha: 0.6),
                      border: Border.all(
                        color: isSelected
                            ? color.withValues(alpha: 0.5)
                            : AppColors.slateGray.withValues(alpha: 0.15),
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.25),
                                blurRadius: 12,
                                spreadRadius: 0,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isSelected ? activeIcon : inactiveIcon,
                      color: isSelected
                          ? color
                          : AppColors.coolGray.withValues(alpha: 0.6),
                      size: 20.sp,
                    ),
                  ),
                  AppSpacing.horizontalSpacing(AppSpacing.l),

                  // Label + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyles.font14RegularPureWhiteManrope
                              .copyWith(
                                fontWeight: isSelected
                                    ? Weights.bold
                                    : Weights.semiBold,
                                color: isSelected
                                    ? AppColors.pureWhite
                                    : AppColors.platinumGray,
                              ),
                        ),
                        AppSpacing.verticalSpacing(2),
                        Text(
                          subtitle,
                          style: TextStyles.font12RegularCoolGrayManrope
                              .copyWith(
                                fontSize: 11.sp,
                                color: AppColors.coolGray.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Right toggle: loading spinner → checkmark → empty circle
                  _ToggleIndicator(
                    isSelected: isSelected,
                    isLoading: isLoading,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: AppColors.slateGray.withValues(alpha: 0.08),
            height: 1,
            indent: 60.w,
          ),
      ],
    );
  }
}

/// Animated right-side toggle indicator.
/// States: empty circle → loading spinner → filled checkmark
class _ToggleIndicator extends StatefulWidget {
  const _ToggleIndicator({
    required this.isSelected,
    required this.isLoading,
    required this.color,
  });

  final bool isSelected;
  final bool isLoading;
  final Color color;

  @override
  State<_ToggleIndicator> createState() => _ToggleIndicatorState();
}

class _ToggleIndicatorState extends State<_ToggleIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    if (widget.isSelected) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(_ToggleIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animate the checkmark pop when transitioning to selected
    if (!oldWidget.isSelected && widget.isSelected) {
      _controller.forward(from: 0.0);
    } else if (oldWidget.isSelected && !widget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.r,
      height: 28.r,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: widget.isLoading
            ? _buildLoading()
            : widget.isSelected
            ? _buildCheckmark()
            : _buildEmpty(),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      key: const ValueKey('loading'),
      width: 22.r,
      height: 22.r,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );
  }

  Widget _buildCheckmark() {
    return ScaleTransition(
      key: const ValueKey('checked'),
      scale: _scaleAnim,
      child: Container(
        width: 26.r,
        height: 26.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(
          Icons.check_rounded,
          size: 14.sp,
          color: AppColors.trueBlack,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      key: const ValueKey('empty'),
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.slateGray.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
    );
  }
}
