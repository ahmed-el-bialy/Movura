import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/spacing.dart';
import '../../theming/app_colors.dart';
import '../../theming/text_styles.dart';

class WatchlistOptionsSheet extends StatefulWidget {
  const WatchlistOptionsSheet({super.key});

  @override
  State<WatchlistOptionsSheet> createState() => _WatchlistOptionsSheetState();
}

class _WatchlistOptionsSheetState extends State<WatchlistOptionsSheet> {
  final Map<String, bool> _states = {
    'Watchlist': false,
    'Watched': false,
    'Favorite': false,
  };

  void _toggleState(String label, IconData icon, Color color) {
    setState(() {
      _states[label] = !(_states[label] ?? false);
    });

    final isAdded = _states[label]!;

    // Close the sheet after a small delay to show the change, or keep it open?
    // The user said "لما أضغط يعمل تمت إضافته ولما أضغط تاني تم حذفه".

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
            horizontalSpacing(12),
            Text(
              isAdded ? 'Added to $label' : 'Removed from $label',
              style: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
        backgroundColor: isAdded
            ? color.withValues(alpha: 0.9)
            : AppColors.softRed.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
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
          verticalSpacing(24),
          Row(
            children: [
              Text(
                'Add to My Lists',
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
          verticalSpacing(4),
          Text(
            'Organize your movies and series into custom collections',
            style: TextStyles.font12CoolGrayManrope.copyWith(
              color: AppColors.coolGray.withValues(alpha: 0.8),
            ),
          ),
          verticalSpacing(36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActionItem(
                icon: _states['Watchlist']!
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_outline_rounded,
                label: 'Watchlist',
                isSelected: _states['Watchlist']!,
                onTap: () => _toggleState(
                  'Watchlist',
                  Icons.bookmark_rounded,
                  AppColors.neonBlue,
                ),
                color: AppColors.neonBlue,
              ),
              _ActionItem(
                icon: _states['Watched']!
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                label: 'Watched',
                isSelected: _states['Watched']!,
                onTap: () => _toggleState(
                  'Watched',
                  Icons.check_circle_rounded,
                  AppColors.tealCyan,
                ),
                color: AppColors.tealCyan,
              ),
              _ActionItem(
                icon: _states['Favorite']!
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                label: 'Favorite',
                isSelected: _states['Favorite']!,
                onTap: () => _toggleState(
                  'Favorite',
                  Icons.favorite_rounded,
                  AppColors.softRed,
                ),
                color: AppColors.softRed,
              ),
              _ActionItem(
                icon: Icons.add_box_outlined,
                label: 'Create',
                isSelected: false,
                onTap: () {
                  // Simulation for create list
                },
                color: AppColors.amberGold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    required this.isSelected,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          Material(
            color: isSelected
                ? color.withValues(alpha: 0.15)
                : AppColors.onyxBlack,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              splashColor: color.withValues(alpha: 0.3),
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? color : color.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? color
                      : AppColors.coolGray.withValues(alpha: 0.8),
                  size: 28.sp,
                ),
              ),
            ),
          ),
          verticalSpacing(10),
          Text(
            label,
            style: TextStyles.font10BoldCoolGray.copyWith(
              color: isSelected
                  ? AppColors.pureWhite
                  : AppColors.coolGray.withValues(alpha: 0.7),
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
