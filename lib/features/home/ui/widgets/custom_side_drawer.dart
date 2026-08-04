import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

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
              padding: AppSpacing.symmetric(vertical: 10, horizontal: AppSpacing.m),
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
      padding: AppSpacing.only(
        left: AppSpacing.xl,
        top: 60,
        right: AppSpacing.xl,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: AppColors.pureWhite.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: AppSpacing.all(AppSpacing.s),
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.2),
              ),
            ),
            child: Image.asset(AppConstants.appLogo, height: 45.h),
          ),
          AppSpacing.verticalSpacing(AppSpacing.l),
          Text(
            AppConstants.appName.toUpperCase(),
            style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
              letterSpacing: 4,
              fontSize: 20.sp,
              fontWeight: Weights.black,
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
      padding: AppSpacing.only(
        left: AppSpacing.l,
        top: AppSpacing.xl,
        right: AppSpacing.l,
        bottom: AppSpacing.s,
      ),
      child: Text(
        title,
        style: TextStyles.font10BoldCoolGray.copyWith(
          color: AppColors.neonBlue.withValues(alpha: 0.5),
          letterSpacing: 2,
          fontWeight: Weights.black,
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
      margin: AppSpacing.only(bottom: AppSpacing.xs),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        onTap: onTap,
        contentPadding: AppSpacing.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.xs),
        leading: Container(
          padding: AppSpacing.all(10),
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
          style: TextStyles.font14RegularPureWhiteManrope.copyWith(
            fontWeight: Weights.bold,
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
      padding: AppSpacing.all(20),
      child: InkWell(
        onTap: () {
          context.pop();
          context.pushReplacementNamed(RouteNames.logInScreen);
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: AppSpacing.symmetric(vertical: 14, horizontal: 20),
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
              AppSpacing.horizontalSpacing(AppSpacing.m),
              Text(
                "Sign Out",
                style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                  color: AppColors.softRed,
                  fontWeight: Weights.black,
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
