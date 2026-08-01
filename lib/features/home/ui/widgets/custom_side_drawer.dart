import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/screens/custom_search_delegate.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.richEerieBlack,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.pureWhite.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppConstants.appLogo,
                  height: 60.h,
                  width: 60.w,
                ),
                verticalSpacing(10),
                Text(
                  AppConstants.appName,
                  style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                    letterSpacing: 3,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              children: [
                _buildDrawerItem(
                  icon: Icons.person_outline_rounded,
                  label: 'My Profile',
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.profileScreen);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'My Library',
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.libraryScreen);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.workspace_premium_rounded,
                  label: 'Movura Pro',
                  trailing: Icon(Icons.auto_awesome, color: AppColors.amberGold, size: 20.sp),
                  onTap: () {
                    context.pop();
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
                _buildDrawerItem(
                  icon: Icons.movie_filter_outlined,
                  label: 'Movies',
                  subtitle: 'Trending, Popular, Top Rated',
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: "Discover Movies",
                        endpoint: SeeAllEndpoint.popularMovies,
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.tv_outlined,
                  label: 'TV Series',
                  subtitle: 'Latest & Top Rated Shows',
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: "TV Series",
                        endpoint: SeeAllEndpoint.popularTv,
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.people_outline_rounded,
                  label: 'Celebrities',
                  subtitle: 'Popular actors and directors',
                  onTap: () {
                    context.pop();
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(searchCubit: sl<SearchCubit>()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.upcoming_outlined,
                  label: 'Upcoming',
                  subtitle: 'Coming soon to theaters',
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: "Upcoming Movies",
                        endpoint: SeeAllEndpoint.upcomingMovies,
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.theaters_outlined,
                  label: 'Now Playing',
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: "Now Playing",
                        endpoint: SeeAllEndpoint.nowPlayingMovies,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Divider(color: AppColors.pureWhite.withValues(alpha: 0.05)),
          ),
          _buildDrawerItem(
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
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    Color? iconColor,
    Color? textColor,
  }) {
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
              subtitle,
              style: TextStyles.font10MediumCoolGraySora.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.5),
                fontSize: 11.sp,
              ),
            )
          : null,
      trailing: trailing ?? Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.coolGray.withValues(alpha: 0.3),
        size: 12.sp,
      ),
      onTap: onTap,
    );
  }
}