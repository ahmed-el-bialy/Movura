import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';

import '../../logic/see_all_cubit.dart';

class SeeAllGrid extends StatelessWidget {
  const SeeAllGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeAllCubit, SeeAllState>(
      builder: (context, state) {
        if (state is SeeAllInitial) {
          return const SizedBox();
        } else if (state is SeeAllLoading) {
          return const Center(
            child: MovuraLoadingIndicator(),
          );
        } else if (state is SeeAllError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: AppColors.softRed, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is SeeAllLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                "No items found.",
                style: TextStyle(
                  color: AppColors.platinumGray,
                  fontSize: 16.sp,
                ),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!state.isFetchingMore &&
                  !state.hasReachedMax &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                context.read<SeeAllCubit>().loadMore();
                return true;
              }
              return false;
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppSpacing.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.s,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 12.h,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = state.items[index];
                      return PosterCard(
                        mediaModel: item,
                        mediaType: item.mediaType,
                        elevation: 6,
                        width: double.infinity,
                        height: double.infinity,
                        border: 12,
                        titleStyle: TextStyles.font14BoldIceBlueMontserrat
                            .copyWith(
                              fontSize: 11.sp,
                              fontWeight: Weights.extraBold,
                            ),
                        subTextStyle: TextStyles.font16SemiBoldPlatinumGray
                            .copyWith(fontSize: 10.sp, letterSpacing: 0.5),
                        showMediaType: true,
                        maxLines: 2,
                      );
                    }, childCount: state.items.length),
                  ),
                ),
                if (state.isFetchingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacing.vertical(AppSpacing.xl),
                      child: const Center(
                        child: MovuraLoadingIndicator(size: 60),
                      ),
                    ),
                  ),
                AppSpacing.sliverVerticalSpacing(40),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
