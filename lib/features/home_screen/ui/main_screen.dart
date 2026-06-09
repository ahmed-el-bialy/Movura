import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home_screen/ui/widgets/trending_poster_list.dart';
import 'package:movura/features/home_screen/ui/widgets/top_movies_list.dart';
import 'package:movura/features/home_screen/ui/widgets/top_tv_series_list.dart';

import '../../../core/utils/constants/strings.dart';
import '../../../core/utils/helpers/spacing.dart';
import '../../../core/widgets/app_navigation_bar.dart';
import '../../../core/widgets/section_title.dart';
import '../logic/trending_content/trending_content_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.richEerieBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: AppColors.eerieBlack,
          title: Row(
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
                onTap: () {},
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
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
                    child: TrendingPosterList(trendingContent: state.posters,),
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
