import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: AppColors.richEerieBlack,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacing(20),
                Image.asset(AppConstants.appLogo, height: 60.h),
                verticalSpacing(10),
                Text(
                  AppConstants.appName,
                  style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                    letterSpacing: 3,
                    fontSize: 22.sp,
                  ),
                ),
                verticalSpacing(20)
              ],
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: [
                  _DrawerItem(
                    icon: Icons.workspace_premium_rounded,
                    label: 'Movura Pro',
                    trailing: Icon(
                      Icons.auto_awesome,
                      color: AppColors.amberGold,
                      size: 20.sp,
                    ),
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.favorite_border_rounded,
                    label: 'My Library',
                    onTap: () {
                      context.pop();
                      context.pushNamed(RouteNames.libraryScreen);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
                    child: Text(
                      "DISCOVER",
                      style: TextStyles.font10BoldCoolGray.copyWith(
                        color: AppColors.coolGray.withValues(alpha: 0.6),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  _DrawerItem(
                    icon: Icons.movie_filter_outlined,
                    label: 'Discover Movies',
                    subtitle: 'Trending, Upcoming, Top Rated & More',
                    onTap: () {
                      context.pop();
                      context.pushNamed(RouteNames.discoverMoviesScreen);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.tv_outlined,
                    label: 'TV Series',
                    subtitle: 'Popular, Latest & Top Rated Shows',
                    onTap: () {
                      context.pop();
                      context.pushNamed(RouteNames.discoverTvScreen);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.people_outline_rounded,
                    label: 'Popular People',
                    subtitle: 'Trending actors and directors',
                    onTap: () {
                      context.pop();
                      context.pushNamed(RouteNames.discoverPeopleScreen);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(
                  color: AppColors.pureWhite.withValues(alpha: 0.05)),
            ),
            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Logout',
              iconColor: AppColors.softRed,
              textColor: AppColors.softRed,
              onTap: () {
                context.pop();
                context.pushReplacementNamed(RouteNames.logInScreen);
              },
            ),
            verticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      leading: Icon(icon, color: iconColor ?? AppColors.coolGray, size: 24.sp),
      title: Text(
        label,
        style: TextStyles.font14PureWhiteManrope.copyWith(
          color: textColor ?? AppColors.pureWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyles.font10MediumCoolGraySora.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.5),
                fontSize: 11.sp,
              ),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.coolGray.withValues(alpha: 0.3),
            size: 12.sp,
          ),
      onTap: onTap,
    );
  }
}
