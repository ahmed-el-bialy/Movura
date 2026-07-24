import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/home/logic/trending_content/trending_content_cubit.dart';
import 'package:movura/features/home/ui/widgets/sub_widgets/trending_banner_indicator.dart';
import 'package:movura/features/home/ui/widgets/sub_widgets/trending_banner_item.dart';
import 'package:movura/features/home/ui/widgets/sub_widgets/trending_banner_skeleton.dart';

class HomeTrendingBanner extends StatefulWidget {
  const HomeTrendingBanner({super.key});

  @override
  State<HomeTrendingBanner> createState() => _HomeTrendingBannerState();
}

class _HomeTrendingBannerState extends State<HomeTrendingBanner> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingContentCubit, TrendingContentState>(
      builder: (context, state) {
        if (state is TrendingContentLoading) {
          return const TrendingBannerSkeleton();
        } else if (state is TrendingContentLoaded) {
          final items = state.posters.take(5).toList();
          return Column(
            children: [
              SizedBox(
                height: 420.h,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TrendingBannerItem(
                      poster: items[index],
                      isActive: _currentPage == index,
                    );
                  },
                ),
              ),
              verticalSpacing(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  items.length,
                  (index) => TrendingBannerIndicator(isActive: index == _currentPage),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
