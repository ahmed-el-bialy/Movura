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
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              physics: const BouncingScrollPhysics(),
              children: [
                _DrawerItem(
                  icon: Icons.workspace_premium_rounded,
                  label: 'Movura Pro',
                  iconColor: AppColors.amberGold,
                  trailing: Icon(
                    Icons.auto_awesome,
                    color: AppColors.amberGold,
                    size: 18.sp,
                  ),
                  onTap: () => context.pop(),
                ),
                _DrawerItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'My Library',
                  iconColor: AppColors.neonBlue,
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.libraryScreen);
                  },
                ),
                const _DrawerSectionTitle(title: "DISCOVER"),
                _DrawerItem(
                  icon: Icons.movie_filter_outlined,
                  label: 'Discover Movies',
                  subtitle: 'Trending, Upcoming & More',
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.discoverMoviesScreen);
                  },
                ),
                _DrawerItem(
                  icon: Icons.tv_outlined,
                  label: 'TV Series',
                  subtitle: 'Popular & Latest Shows',
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
                const _DrawerSectionTitle(title: "ACCOUNT"),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => context.pop(),
                ),
              ],
            ),
          ),
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 30.h),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: AppColors.pureWhite.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.2),
              ),
            ),
            child: Image.asset(AppConstants.appLogo, height: 45.h),
          ),
          verticalSpacing(16),
          Text(
            AppConstants.appName.toUpperCase(),
            style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
              letterSpacing: 4,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Ultimate Cinema Guide",
            style: TextStyles.font10MediumCoolGraySora.copyWith(
              letterSpacing: 1.2,
              color: AppColors.coolGray.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  const _DrawerSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 8.h),
      child: Text(
        title,
        style: TextStyles.font10BoldCoolGray.copyWith(
          color: AppColors.neonBlue.withValues(alpha: 0.5),
          letterSpacing: 2,
          fontWeight: FontWeight.w900,
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
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.coolGray).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.platinumGray.withValues(alpha: 0.8),
            size: 22.sp,
          ),
        ),
        title: Text(
          label,
          style: TextStyles.font14PureWhiteManrope.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.pureWhite.withValues(alpha: 0.9),
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
              color: AppColors.coolGray.withValues(alpha: 0.2),
              size: 12.sp,
            ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: InkWell(
        onTap: () {
          context.pop();
          context.pushReplacementNamed(RouteNames.logInScreen);
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppColors.softRed.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.softRed.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: AppColors.softRed, size: 20.sp),
              horizontalSpacing(12),
              Text(
                "Sign Out",
                style: TextStyles.font14PureWhiteManrope.copyWith(
                  color: AppColors.softRed,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
