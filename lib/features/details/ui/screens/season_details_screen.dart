import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/features/details/logic/tv_series_cubit/tv_seasons_cubit/tv_seasons_cubit.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/episode_card.dart';

import '../../../../../core/routing/arguments_model.dart';

class SeasonDetailsScreen extends StatelessWidget {
  const SeasonDetailsScreen({super.key, required this.arguments});

  final SeasonArgumentsModel arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      extendBody: true,
      body: BlocBuilder<TvSeasonsCubit, TvSeasonsState>(
        builder: (context, state) {
          if (state is TvSeasonsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.neonBlue),
            );
          }

          if (state is TvSeasonsFailed) {
            return _SeasonErrorBody(
              message: state.errorMessage,
              onBack: () => context.pop(),
            );
          }

          if (state is TvSeasonsLoaded) {
            final season = state.seasonDetails;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 220.h,
                  pinned: true,
                  stretch: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: AppColors.neonBlue,
                    onPressed: () => context.pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(
                      left: 48.w,
                      right: 16.w,
                      bottom: 12.h,
                    ),
                    title: Text(
                      arguments.seasonName,
                      style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (season.posterPath != null &&
                            season.posterPath!.isNotEmpty)
                          CachedNetworkImage(
                            imageUrl:
                                '${ApiConstants.imageBaseUrl}${season.posterPath}',
                            fit: BoxFit.cover,
                          )
                        else
                          Container(color: AppColors.onyxBlack),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.richEerieBlack.withValues(alpha: 0.9),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (season.overview != null && season.overview!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                      child: Text(
                        season.overview!,
                        style: AppTextStyles.font12CoolGrayManrope.copyWith(
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      '${season.episodes.length} Episodes',
                      style: AppTextStyles.font20SimiBoldPlatinumGray.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        EpisodeCard(episode: season.episodes[index]),
                    childCount: season.episodes.length,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 90.h)),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
    );
  }
}

class _SeasonErrorBody extends StatelessWidget {
  const _SeasonErrorBody({required this.message, required this.onBack});

  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.neonBlue,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font13MediumNeonBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
