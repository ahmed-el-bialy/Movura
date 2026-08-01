import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.charcoalBlack,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.coolGray.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 2.w),
                    child: Image.asset(
                      AppConstants.appLogo,
                      fit: BoxFit.fill,
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                  Text(
                    AppConstants.appName,
                    style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ListTile(
              leading: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.coolGray,
              ),
              title: Text(
                'Profile',
                style: TextStyles.font14PureWhiteManrope,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ListTile(
              leading: const Icon(
                Icons.star_outline_rounded,
                color: AppColors.coolGray,
              ),
              title: Text(
                'Go Pro',
                style: TextStyles.font14PureWhiteManrope,
              ),
              trailing: Icon(
                Icons.auto_awesome,
                color: AppColors.neonBlue,
                size: 22.sp,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(color: AppColors.pureWhite.withValues(alpha: 0.1)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              "DISCOVER",
              style: TextStyles.font10BoldCoolGray.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.8),
                letterSpacing: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: const Icon(
                Icons.movie_filter_outlined,
                color: AppColors.coolGray,
              ),
              title: Text(
                'Discover Movies',
                style: TextStyles.font14PureWhiteManrope,
              ),
              subtitle: Text(
                'Popular, Top Rated, Upcoming',
                style: TextStyles.font10MediumCoolGraySora.copyWith(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: const Icon(Icons.tv_outlined, color: AppColors.coolGray),
              title: Text(
                'TV Series',
                style: TextStyles.font14PureWhiteManrope,
              ),
              subtitle: Text(
                'Popular, Top Rated, On The Air',
                style: TextStyles.font10MediumCoolGraySora.copyWith(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: const Icon(
                Icons.people_alt_outlined,
                color: AppColors.coolGray,
              ),
              title: Text(
                'Popular People',
                style: TextStyles.font14PureWhiteManrope,
              ),
              subtitle: Text(
                'Trending Actors & Creators',
                style: TextStyles.font10MediumCoolGraySora.copyWith(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {},
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(color: AppColors.pureWhite.withValues(alpha: 0.1)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: AppColors.softRed,
              ),
              title: Text(
                'Logout',
                style: TextStyles.font14PureWhiteManrope.copyWith(
                  color: AppColors.softRed,
                ),
              ),
              onTap: () {
                context.pop();
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12.h),
        ],
      ),
    );
  }
}
