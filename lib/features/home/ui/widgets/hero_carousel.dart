import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/app_shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeroCarousel extends StatefulWidget {
  final List<PosterModel> posters;

  const HeroCarousel({
    super.key,
    required this.posters,
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    if (widget.posters.length > 1) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || widget.posters.isEmpty) return;
      _currentPage = (_currentPage + 1) % widget.posters.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posters.isEmpty) return const SizedBox.shrink();

    final heroItems = widget.posters.take(6).toList();

    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: heroItems.length,
            itemBuilder: (context, index) {
              final item = heroItems[index];
              final imageUrl = (item.posterPath != null && item.posterPath!.isNotEmpty)
                  ? "${ApiConstants.imageBaseUrl}${item.posterPath}"
                  : (item.profilePath != null && item.profilePath!.isNotEmpty)
                      ? "${ApiConstants.imageBaseUrl}${item.profilePath}"
                      : "";
              return Padding(
                padding: AppSpacing.horizontal(6),
                child: GestureDetector(
                  onTap: () {
                    final mType = (item.mediaType != null && item.mediaType!.isNotEmpty)
                        ? item.mediaType!
                        : "movie";
                    context.pushNamed(
                      RouteNames.detailsScreen,
                      arguments: DetailsArgumentModel(
                        mediaType: mType,
                        mediaId: item.id,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (imageUrl.isNotEmpty)
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const ShimmerBox(
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.onyxBlack,
                                child: Icon(
                                  Icons.movie_rounded,
                                  color: AppColors.neonBlue,
                                  size: 40.sp,
                                ),
                              ),
                            )
                          else
                            Container(color: AppColors.onyxBlack),

                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.richEerieBlack.withValues(alpha: 0.4),
                                  AppColors.richEerieBlack.withValues(alpha: 0.95),
                                ],
                                stops: const [0.2, 0.6, 1.0],
                              ),
                            ),
                          ),

                          // Content details
                          Positioned(
                            left: 16.w,
                            right: 16.w,
                            bottom: 16.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: AppSpacing.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.neonBlue.withValues(alpha: 0.25),
                                        borderRadius: BorderRadius.circular(6.r),
                                        border: Border.all(
                                          color: AppColors.neonBlue.withValues(alpha: 0.5),
                                        ),
                                      ),
                                      child: Text(
                                        (item.mediaType ?? "MOVIE").toUpperCase(),
                                        style: TextStyles.font10BoldCoolGray.copyWith(
                                          color: AppColors.neonBlue,
                                          fontSize: 9.sp,
                                          fontWeight: Weights.bold,
                                        ),
                                      ),
                                    ),
                                    if (item.voteAverage != null && item.voteAverage! > 0) ...[
                                      AppSpacing.horizontalSpacing(8),
                                      Icon(
                                        Icons.star_rounded,
                                        color: AppColors.amberGold,
                                        size: 14.sp,
                                      ),
                                      AppSpacing.horizontalSpacing(3),
                                      Text(
                                        item.voteAverage!.toStringAsFixed(1),
                                        style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                                          color: AppColors.iceBlue,
                                          fontWeight: Weights.bold,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                AppSpacing.verticalSpacing(6),
                                Text(
                                  item.title ?? item.name ?? 'Untitled',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                                    fontSize: 16.sp,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.trueBlack,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        AppSpacing.verticalSpacing(10),
        SmoothPageIndicator(
          controller: _pageController,
          count: heroItems.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.neonBlue,
            dotColor: AppColors.coolGray.withValues(alpha: 0.3),
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 3,
            spacing: 4.w,
          ),
        ),
      ],
    );
  }
}
