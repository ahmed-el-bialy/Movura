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

/// Maximum number of items shown in the Hero spotlight.
const _kHeroItemCount = 8;

/// A large virtual page count so modulo-wrapping creates an
/// infinite-loop effect without noticeable jumps.
const _kVirtualCount = 99999;

/// Midpoint used as the initial page so the user can swipe in both
/// directions and the modulo maths always lands on a real item.
const _kInitialPage = (_kVirtualCount ~/ 2);

class HeroCarousel extends StatefulWidget {
  final List<PosterModel> posters;

  const HeroCarousel({super.key, required this.posters});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _pageController;
  late final List<PosterModel> _heroItems;
  Timer? _autoPlayTimer;
  int _currentRealIndex = 0;

  @override
  void initState() {
    super.initState();
    _heroItems = widget.posters.take(_kHeroItemCount).toList();
    _pageController = PageController(
      viewportFraction: 0.92,
      initialPage: _kInitialPage,
    );
    if (_heroItems.length > 1) _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _heroItems.isEmpty) return;
      _pageController.nextPage(
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
    if (_heroItems.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 230.h,
          child: PageView.builder(
            controller: _pageController,
            // Infinite virtual count — modulo keeps it looping.
            itemCount: _kVirtualCount,
            onPageChanged: (virtualIndex) {
              setState(() {
                _currentRealIndex = virtualIndex % _heroItems.length;
              });
            },
            itemBuilder: (context, virtualIndex) {
              final realIndex = virtualIndex % _heroItems.length;
              final item = _heroItems[realIndex];
              final imageUrl = _resolveImage(item);

              return Padding(
                padding: AppSpacing.horizontal(6),
                child: GestureDetector(
                  onTap: () {
                    final mType =
                        (item.mediaType != null && item.mediaType!.isNotEmpty)
                        ? item.mediaType!
                        : 'movie';
                    context.pushNamed(
                      RouteNames.detailsScreen,
                      arguments: DetailsArgumentModel(
                        mediaType: mType,
                        mediaId: item.id,
                      ),
                    );
                  },
                  child: _HeroCard(item: item, imageUrl: imageUrl),
                ),
              );
            },
          ),
        ),
        AppSpacing.verticalSpacing(10),
        AnimatedSmoothIndicator(
          activeIndex: _currentRealIndex,
          count: _heroItems.length,
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

  /// Prefers the wide w780 image for a more cinematic crop.
  /// Falls back to poster then profile path.
  String _resolveImage(PosterModel item) {
    if (item.posterPath != null && item.posterPath!.isNotEmpty) {
      return '${ApiConstants.imageBaseUrlW780}${item.posterPath}';
    }
    if (item.profilePath != null && item.profilePath!.isNotEmpty) {
      return '${ApiConstants.imageBaseUrl}${item.profilePath}';
    }
    return '';
  }
}

// ---------------------------------------------------------------------------
// Private card widget
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.item, required this.imageUrl});

  final PosterModel item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image — topCenter alignment shows faces/titles.
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                placeholder: (context, url) => const ShimmerBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => _FallbackPlaceholder(),
              )
            else
              _FallbackPlaceholder(),

            // Bottom gradient for readability.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.richEerieBlack.withValues(alpha: 0.35),
                    AppColors.richEerieBlack.withValues(alpha: 0.92),
                  ],
                  stops: const [0.25, 0.58, 1.0],
                ),
              ),
            ),

            // Text content overlay.
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 14.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _MediaTypeBadge(mediaType: item.mediaType),
                      if (item.voteAverage != null &&
                          item.voteAverage! > 0) ...[
                        AppSpacing.horizontalSpacing(8),
                        Icon(
                          Icons.star_rounded,
                          color: AppColors.amberGold,
                          size: 13.sp,
                        ),
                        AppSpacing.horizontalSpacing(3),
                        Text(
                          item.voteAverage!.toStringAsFixed(1),
                          style: TextStyles.font12RegularCoolGrayManrope
                              .copyWith(
                                color: AppColors.iceBlue,
                                fontWeight: Weights.bold,
                                fontSize: 11.sp,
                              ),
                        ),
                      ],
                    ],
                  ),
                  AppSpacing.verticalSpacing(5),
                  Text(
                    item.title ?? item.name ?? 'Untitled',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 15.sp,
                      shadows: [
                        Shadow(color: AppColors.trueBlack, blurRadius: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaTypeBadge extends StatelessWidget {
  const _MediaTypeBadge({required this.mediaType});

  final String? mediaType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.neonBlue.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.45)),
      ),
      child: Text(
        (mediaType ?? 'MOVIE').toUpperCase(),
        style: TextStyles.font10BoldCoolGray.copyWith(
          color: AppColors.neonBlue,
          fontSize: 9.sp,
          fontWeight: Weights.bold,
        ),
      ),
    );
  }
}

class _FallbackPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onyxBlack,
      child: Center(
        child: Icon(
          Icons.movie_rounded,
          color: AppColors.neonBlue,
          size: 40.sp,
        ),
      ),
    );
  }
}

/// Skeleton placeholder for HeroCarousel during initial data fetch
class HeroCarouselSkeleton extends StatelessWidget {
  const HeroCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: AppSpacing.horizontal(16),
            child: ShimmerBox(
              width: double.infinity,
              height: 230.h,
              borderRadius: 20.r,
            ),
          ),
          AppSpacing.verticalSpacing(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Padding(
                padding: AppSpacing.horizontal(2),
                child: ShimmerBox(
                  width: index == 0 ? 18.w : 6.w,
                  height: 6.h,
                  borderRadius: 3.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
