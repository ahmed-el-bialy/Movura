import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/context_extension.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

import '../../../discover/data/repo/discover_repo.dart';
import '../../../see_all/data/models/see_all_arguments.dart';
import 'drawer_widgets/drawer_header.dart';
import 'drawer_widgets/drawer_item.dart';
import 'drawer_widgets/drawer_logout_button.dart';
import 'drawer_widgets/drawer_section_title.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.8,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
        children: [
          const CustomDrawerHeader(),
          Expanded(
            child: ListView(
              padding: AppSpacing.symmetric(
                vertical: 10,
                horizontal: AppSpacing.m,
              ),
              physics: const BouncingScrollPhysics(),
              children: [
                DrawerItem(
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
                DrawerItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'My Library',
                  iconColor: AppColors.neonBlue,
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.libraryScreen);
                  },
                ),
                DrawerItem(
                  icon: Icons.search_rounded,
                  label: 'Quick Search',
                  iconColor: AppColors.tealCyan,
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.searchScreen);
                  },
                ),
                const DrawerSectionTitle(title: 'DISCOVER'),
                DrawerItem(
                  icon: Icons.category_outlined,
                  label: 'Browse Genres',
                  subtitle: 'Explore cinematic themes',
                  iconColor: AppColors.neonBlue,
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.discoverByGenreScreen);
                  },
                ),
                DrawerItem(
                  icon: Icons.movie_outlined,
                  label: 'Popular Movies',
                  subtitle: 'Global box office hits',
                  iconColor: AppColors.tealCyan,
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: 'Popular Movies',
                        futureMethod: sl<DiscoverRepo>().getPopularMovies,
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.tv_rounded,
                  label: 'Popular TV Shows',
                  subtitle: 'Binge-worthy series',
                  iconColor: AppColors.electricBlueAccent,
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      RouteNames.seeAllScreen,
                      arguments: SeeAllArguments(
                        title: 'Popular TV Shows',
                        futureMethod: sl<DiscoverRepo>().getPopularTvShows,
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Trending Actors',
                  subtitle: 'Stars of the screen',
                  iconColor: AppColors.amberGold,
                  onTap: () {
                    context.pop();
                    context.pushNamed(RouteNames.discoverPeopleScreen);
                  },
                ),
                const DrawerSectionTitle(title: 'APP & SUPPORT'),
                DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  iconColor: AppColors.slateGray,
                  onTap: () => context.pop(),
                ),
                DrawerItem(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Feedback',
                  iconColor: AppColors.slateGray,
                  onTap: () => context.pop(),
                ),
                DrawerItem(
                  icon: Icons.info_outline_rounded,
                  label: 'About Movura',
                  iconColor: AppColors.slateGray,
                  onTap: () => context.pop(),
                ),
              ],
            ),
          ),
          const DrawerLogoutButton(),
        ],
      ),
    );
  }
}
