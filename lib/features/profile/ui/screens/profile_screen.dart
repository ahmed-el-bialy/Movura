import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(30),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100.r,
                        height: 100.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.onyxBlack,
                          border: Border.all(color: AppColors.neonBlue, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neonBlue.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 60.sp,
                          color: AppColors.neonBlue,
                        ),
                      ),
                      verticalSpacing(16),
                      Text(
                        'John Doe',
                        style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                          color: AppColors.iceBlue,
                        ),
                      ),
                      Text(
                        'Cinematic Explorer',
                        style: TextStyles.font12CoolGrayManrope,
                      ),
                    ],
                  ),
                ),
                verticalSpacing(40),
                Text(
                  'YOUR COLLECTIONS',
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    letterSpacing: 1.5,
                    color: AppColors.neonBlue.withValues(alpha: 0.7),
                  ),
                ),
                verticalSpacing(16),
                _ProfileCollectionTile(
                  title: 'Watchlist',
                  count: 12,
                  icon: Icons.bookmark_outline_rounded,
                  color: AppColors.neonBlue,
                  onTap: () {},
                ),
                _ProfileCollectionTile(
                  title: 'Favorites',
                  count: 5,
                  icon: Icons.favorite_border_rounded,
                  color: AppColors.deepCrimson,
                  onTap: () {},
                ),
                _ProfileCollectionTile(
                  title: 'Watched History',
                  count: 48,
                  icon: Icons.check_circle_outline_rounded,
                  color: AppColors.tealCyan,
                  onTap: () {},
                ),
                _ProfileCollectionTile(
                  title: 'Planned for Later',
                  count: 8,
                  icon: Icons.schedule_rounded,
                  color: AppColors.amberGold,
                  onTap: () {},
                ),
                verticalSpacing(30),
                Text(
                  'SETTINGS',
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    letterSpacing: 1.5,
                    color: AppColors.neonBlue.withValues(alpha: 0.7),
                  ),
                ),
                verticalSpacing(16),
                _ProfileCollectionTile(
                  title: 'App Settings',
                  icon: Icons.settings_outlined,
                  color: AppColors.slateGray,
                  onTap: () {},
                ),
                _ProfileCollectionTile(
                  title: 'Log Out',
                  icon: Icons.logout_rounded,
                  color: AppColors.softRed,
                  onTap: () {},
                ),
                verticalSpacing(100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCollectionTile extends StatelessWidget {
  const _ProfileCollectionTile({
    required this.title,
    this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final int? count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: AppColors.onyxBlack.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: color.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 22.sp),
                ),
                horizontalSpacing(16),
                Text(
                  title,
                  style: TextStyles.font14PureWhiteManrope.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (count != null)
                  Text(
                    '$count',
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.coolGray,
                    ),
                  ),
                horizontalSpacing(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.coolGray.withValues(alpha: 0.5),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
