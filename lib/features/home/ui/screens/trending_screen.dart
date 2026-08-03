import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/buttons/app_icon_button.dart';
import 'package:movura/core/widgets/loading/skeleton_posters_list_loading.dart';
import 'package:movura/core/widgets/navigation/app_navigation_bar.dart';

import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/layout/posters_sliver_grid.dart';
import '../../logic/trending_content/trending_content_cubit.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.richEerieBlack,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            leading: AppIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Trending Today',
              style: TextStyles.font20SemiBoldNeonBlueManrope.copyWith(
                fontSize: 18.sp,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.eerieBlack.withValues(alpha: 0.85),
          ),
          BlocBuilder<TrendingContentCubit, TrendingContentState>(
            builder: (context, state) {
              if (state is TrendingContentLoading) {
                return const SliverToBoxAdapter(
                  child: SkeletonPostersListLoading(),
                );
              }

              if (state is TrendingContentError) {
                return SliverFillRemaining(
                  child: AppErrorWidget(
                    errorMessage: state.errorMessage,
                    onRetry: () => context
                        .read<TrendingContentCubit>()
                        .getTrendingPosters(),
                  ),
                );
              }

              if (state is TrendingContentLoaded) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  sliver: PostersSliverGrid(posters: state.posters),
                );
              }

              return const SliverToBoxAdapter(
                child: AppErrorWidget(errorMessage: "Something went wrong"),
              );
            },
          ),
          AppSpacing.sliverVerticalSpacing(90),
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
    );
  }
}
