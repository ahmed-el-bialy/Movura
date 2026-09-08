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

const _kHeroItemCount = 8;
const _kVirtualCount = 99999;
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
      viewportFraction: 0.90,
      initialPage: _kInitialPage,
    );
    if (_heroItems.length > 1) _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _heroItems.isEmpty) return;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
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
          height: 235.h,
          child: PageView.builder(
            controller: _pageController,
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

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 0.0;
                  if (_pageController.position.haveDimensions) {
                    value = (virtualIndex - (_pageController.page ?? 0));
                    value = (1 - (value.abs() * 0.12)).clamp(0.88, 1.0);
                  } else {
                    value = virtualIndex == _kInitialPage ? 1.0 : 0.88;
                  }

                  return Transform.scale(
                    scale: value,
                    child: Padding(
                      padding: AppSpacing.horizontal(4),
                      child: GestureDetector(
                        onTap: () {
                          final mType = (item.mediaType != null &&
                                  item.mediaType!.isNotEmpty)
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
                    ),
                  );
                },
              );
            },
          ),
        ),
        AppSpacing.verticalSpacing(12),
        AnimatedSmoothIndicator(
          activeIndex: _currentRealIndex,
          count: _heroItems.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.neonBlue,
            dotColor: AppColors.coolGray.withValues(alpha: 0.25),
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 3.5,
            spacing: 5.w,
          ),
        ),
      ],
    );
  }

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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.item, required this.imageUrl});

  final PosterModel item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
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

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.richEerieBlack.withValues(alpha: 0.35),
                    AppColors.richEerieBlack.withValues(alpha: 0.94),
                  ],
                  stops: const [0.25, 0.55, 1.0],
                ),
              ),
            ),

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
                          size: 14.sp,
                        ),
                        AppSpacing.horizontalSpacing(3),
                        Text(
                          item.voteAverage!.toStringAsFixed(1),
                          style: TextStyles.font12RegularCoolGrayManrope
                              .copyWith(
                                color: AppColors.iceBlue,
                                fontWeight: Weights.bold,
                                fontSize: 12.sp,
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
                        Shadow(color: AppColors.trueBlack, blurRadius: 10),
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
      padding: AppSpacing.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neonBlue.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.45)),
      ),
      child: Text(
        (mediaType ?? 'MOVIE').toUpperCase(),
        style: TextStyles.font10BoldCoolGray.copyWith(
          color: AppColors.neonBlue,
          fontSize: 9.sp,
          fontWeight: Weights.bold,
          letterSpacing: 0.8,
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
          size: 44.sp,
        ),
      ),
    );
  }
}

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
              height: 235.h,
              borderRadius: 22.r,
            ),
          ),
          AppSpacing.verticalSpacing(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Padding(
                padding: AppSpacing.horizontal(2),
                child: ShimmerBox(
                  width: index == 0 ? 20.w : 6.w,
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
