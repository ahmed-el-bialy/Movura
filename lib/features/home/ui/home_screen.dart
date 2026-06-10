import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home/ui/widgets/top_movies_list.dart';
import 'package:movura/features/home/ui/widgets/top_tv_series_list.dart';
import 'package:movura/features/home/ui/widgets/trending_poster_list.dart';

import '../../../core/networking/di.dart';
import '../../../core/utils/constants/strings.dart';
import '../../../core/utils/helpers/spacing.dart';
import '../../../core/widgets/app_navigation_bar.dart';
import '../../../core/widgets/section_title.dart';
import '../../search/custom_search_delegate.dart';
import '../../search/logic/search/search_cubit.dart';
import '../logic/trending_content/trending_content_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSideDrawer(),
      extendBody: true,
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(
                      Icons.notes,
                      color: AppColors.neonCyan,
                      size: 30.sp,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              centerTitle: true,
              backgroundColor: AppColors.eerieBlack,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image.asset(
                      "assets/images/mini_icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      Strings.appName,
                      style: Styles.font24SimiBoldNeonCyanManrope,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: InkWell(
                    splashColor: AppColors.neonCyan.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () {
                      final searchCubit = sl<SearchCubit>();
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(
                          searchCubit: searchCubit,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Icon(
                        Icons.search_outlined,
                        size: 26.sp,
                        color: AppColors.slateGray,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(child: verticalSpacing(15)),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Trending Now",
                actionName: "See All ",
              ),
            ),
            BlocBuilder<TrendingContentCubit, TrendingContentState>(
              builder: (context, state) {
                if (state is TrendingContentLoading) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 340.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.neonCyan,
                        ),
                      ),
                    ),
                  );
                } else if (state is TrendingContentLoaded) {
                  return SliverToBoxAdapter(
                    child: TrendingPosterList(trendingContent: state.posters),
                  );
                } else if (state is TrendingContentFailed) {
                  return SliverToBoxAdapter(
                    child: Text(
                      state.errorMessage,
                      style: Styles.font13MediumNeonCyan,
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Text(
                      state.toString(),
                      style: Styles.font13MediumNeonCyan,
                    ),
                  );
                }
              },
            ),
            SliverToBoxAdapter(child: verticalSpacing(25)),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated Movies",
                actionName: "See All ",
              ),
            ),

            SliverToBoxAdapter(child: TopMoviesList()),
            SliverToBoxAdapter(child: verticalSpacing(25)),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated TV Series",
                actionName: "See All ",
              ),
            ),
            SliverToBoxAdapter(child: TopTvSeriesList()),

            SliverToBoxAdapter(child: verticalSpacing(50)),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(activeIndex: 0),
    );
  }
}

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image.asset(
                      "assets/images/mini_icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      Strings.appName,
                      style: TextStyle(
                        color: AppColors.neonCyan,
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

          ListTile(
            leading: Icon(Icons.person, color: AppColors.coolGray),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star, color: AppColors.coolGray),
            title: const Text('Go Pro', style: TextStyle(color: Colors.white)),
            trailing: Icon(
              Icons.auto_awesome,
              color: AppColors.neonCyan,
              size: 22.sp,
            ),
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
