import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/features/see_all/logic/see_all_cubit.dart';

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
            child: CircularProgressIndicator(color: AppColors.neonBlue),
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
                style: TextStyle(color: AppColors.platinumGray, fontSize: 16.sp),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.items[index];
                        return PosterCard(
                          mediaModel: item,
                          mediaType: item.mediaType,
                        );
                      },
                      childCount: state.items.length,
                    ),
                  ),
                ),
                if (state.isFetchingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.neonBlue,
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: verticalSpacing(40)),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
