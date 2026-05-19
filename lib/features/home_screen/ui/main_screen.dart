
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home_screen/ui/widgets/poster_list_builder.dart';
import 'package:movura/features/home_screen/ui/widgets/sub_poster_list_builder.dart';

import '../../../core/helper/constants/strings.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/widgets/app_navigation_bar.dart';
import '../../../core/widgets/section_title.dart';
import '../logic/main_content/main_content_cubit.dart';

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
              Text(
                Strings.appName,
                style: Styles.font24NeonCyanSimiBoldManrope,
              ),
              Spacer(flex: 1)
              , verticalSpacing(60.h),
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
                actionName: "View All >> ",
              ),
            ),
            BlocBuilder<MainContentCubit, MainContentState>(
              builder: (context, state) {
                if (state is MainContentLoading) {
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
                } else if (state is MainContentLoaded) {
                  return SliverToBoxAdapter(child: PosterListBuilder(
                    trendingContent: state.posters,));
                } else if (state is MainContentFailed) {
                  return SliverToBoxAdapter(
                    child: Text(
                      state.errorMessage,
                      style: Styles.font13NeonCyanMedium,
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Text(
                      state.toString()
                      ,
                      style: Styles.font13NeonCyanMedium,
                    ),
                  );
                }
              },
            ),
            SliverToBoxAdapter(child: verticalSpacing(25)),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated",
                actionName: "View All >> ",
              ),
            ),
            SliverToBoxAdapter(child: SubPosterListBuilder()),
          ],
        ),)
      ,
      bottomNavigationBar: AppNavigationBar(activeIndex: 0,),
    );
  }
}
  enum MovieTab { media, cast, similar }
