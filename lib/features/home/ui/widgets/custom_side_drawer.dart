import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import 'package:movura/core/helpers/spacing.dart';

class _CategoryOption {
  final String label;
  final String? subtitle;
  final IconData icon;
  final SeeAllEndpoint endpoint;

  const _CategoryOption({
    required this.label,
    this.subtitle,
    required this.icon,
    required this.endpoint,
  });
}

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  void _showCategorySheet(
    BuildContext context, {
    required String title,
    required List<_CategoryOption> options,
  }) {
    context.pop(); // Close drawer first
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.richEerieBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.coolGray.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              verticalSpacing(16),
              Text(
                title,
                style: TextStyles.font20SimiBoldPlatinumGray,
              ),
              verticalSpacing(12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, _) => Divider(
                    color: AppColors.pureWhite.withValues(alpha: 0.08),
                  ),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      leading: Icon(option.icon, color: AppColors.neonBlue, size: 22.sp),
                      title: Text(
                        option.label,
                        style: TextStyles.font14PureWhiteManrope,
                      ),
                      subtitle: option.subtitle != null
                          ? Text(
                              option.subtitle!,
                              style: TextStyles.font10MediumCoolGraySora.copyWith(
                                color: AppColors.coolGray.withValues(alpha: 0.7),
                              ),
                            )
                          : null,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.coolGray.withValues(alpha: 0.5),
                        size: 14.sp,
                      ),
                      onTap: () {
                        context.pop();
                        context.pushNamed(
                          RouteNames.seeAllScreen,
                          arguments: SeeAllArguments(
                            title: option.label,
                            endpoint: option.endpoint,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                'Trending, Popular, Top Rated, Upcoming',
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
              onTap: () {
                _showCategorySheet(
                  context,
                  title: 'Discover Movies',
                  options: const [
                    _CategoryOption(
                      label: 'Trending Today',
                      subtitle: 'Movies trending right now',
                      icon: Icons.whatshot_rounded,
                      endpoint: SeeAllEndpoint.trendingMoviesDay,
                    ),
                    _CategoryOption(
                      label: 'Trending This Week',
                      subtitle: 'Popular movies this week',
                      icon: Icons.local_fire_department_rounded,
                      endpoint: SeeAllEndpoint.trendingMoviesWeek,
                    ),
                    _CategoryOption(
                      label: 'Popular Movies',
                      subtitle: 'Most viewed movies',
                      icon: Icons.star_rounded,
                      endpoint: SeeAllEndpoint.popularMovies,
                    ),
                    _CategoryOption(
                      label: 'Top Rated Movies',
                      subtitle: 'Highest rated of all time',
                      icon: Icons.military_tech_rounded,
                      endpoint: SeeAllEndpoint.topRatedMovies,
                    ),
                    _CategoryOption(
                      label: 'Upcoming Movies',
                      subtitle: 'Coming soon to theaters',
                      icon: Icons.upcoming_rounded,
                      endpoint: SeeAllEndpoint.upcomingMovies,
                    ),
                    _CategoryOption(
                      label: 'Now Playing',
                      subtitle: 'In theaters now',
                      icon: Icons.movie_creation_rounded,
                      endpoint: SeeAllEndpoint.nowPlayingMovies,
                    ),
                  ],
                );
              },
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
                'Trending, Popular, Top Rated, On Air',
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
              onTap: () {
                _showCategorySheet(
                  context,
                  title: 'TV Series',
                  options: const [
                    _CategoryOption(
                      label: 'Trending Today',
                      subtitle: 'TV shows trending today',
                      icon: Icons.whatshot_rounded,
                      endpoint: SeeAllEndpoint.trendingTvDay,
                    ),
                    _CategoryOption(
                      label: 'Trending This Week',
                      subtitle: 'TV shows trending this week',
                      icon: Icons.local_fire_department_rounded,
                      endpoint: SeeAllEndpoint.trendingTvWeek,
                    ),
                    _CategoryOption(
                      label: 'Popular TV Shows',
                      subtitle: 'Most watched TV series',
                      icon: Icons.star_rounded,
                      endpoint: SeeAllEndpoint.popularTv,
                    ),
                    _CategoryOption(
                      label: 'Top Rated TV Shows',
                      subtitle: 'Highest rated TV series',
                      icon: Icons.military_tech_rounded,
                      endpoint: SeeAllEndpoint.topRatedTv,
                    ),
                    _CategoryOption(
                      label: 'On The Air',
                      subtitle: 'Currently airing episodes',
                      icon: Icons.live_tv_rounded,
                      endpoint: SeeAllEndpoint.onTheAirTv,
                    ),
                  ],
                );
              },
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
