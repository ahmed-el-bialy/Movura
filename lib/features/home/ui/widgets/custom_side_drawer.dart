import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/routing_extension.dart';

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
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image.asset(
                      AppConstants.appLogo,
                      fit: BoxFit.fill,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      AppConstants.appName,
                      style: TextStyle(
                        color: AppColors.neonBlue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ListTile(
              leading: Icon(
                Icons.person_outline_rounded,
                color: AppColors.coolGray,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // context.pop();
                // context.pushNamed(Strings.profileScreen);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ListTile(
              leading: Icon(
                Icons.star_outline_rounded,
                color: AppColors.coolGray,
              ),
              title: const Text(
                'Go Pro',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.auto_awesome,
                color: AppColors.neonBlue,
                size: 22.sp,
              ),
              onTap: () {
                // context.pop();
                // context.pushNamed(Strings.goProScreen);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(color: Colors.white10),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              "DISCOVER",
              style: TextStyle(
                color: AppColors.coolGray.withValues(alpha: 0.8),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: Icon(
                Icons.movie_filter_outlined,
                color: AppColors.coolGray,
              ),
              title: const Text(
                'Discover Movies',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Popular, Top Rated, Upcoming',
                style: TextStyle(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {
                // context.pop();
                // context.pushNamed(Strings.moviesCategoryScreen);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: Icon(Icons.tv_outlined, color: AppColors.coolGray),
              title: const Text(
                'TV Series',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Popular, Top Rated, On The Air',
                style: TextStyle(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {
                // context.pop();
                // context.pushNamed(Strings.tvCategoryScreen);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ListTile(
              leading: Icon(
                Icons.people_alt_outlined,
                color: AppColors.coolGray,
              ),
              title: const Text(
                'Popular People',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Trending Actors & Creators',
                style: TextStyle(
                  color: AppColors.coolGray.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              onTap: () {
                // context.pop();
                // context.pushNamed(Strings.popularPeopleScreen);
              },
            ),
          ),

          const Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(color: Colors.white10),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
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