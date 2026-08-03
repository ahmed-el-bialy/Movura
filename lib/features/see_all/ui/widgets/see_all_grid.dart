import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/widgets/movura_loading_indicator.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/poster_card/poster_card.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
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
                              fontWeight: FontWeight.w800,
                            ),
                        subTextStyle: TextStyles.font16SimiBoldPlatinumGray
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
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: const Center(
                        child: MovuraLoadingIndicator(size: 60),
                      ),
                    ),
                  ),
                sliverVerticalSpacing(40),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
