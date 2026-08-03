import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';

import 'package:movura/core/theming/app_spacing.dart';
import '../../theming/text_styles.dart';

class CustomPostersGridView extends StatelessWidget {
  const CustomPostersGridView({
    super.key,
    required this.posters,
    this.isLoadingMore = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  final List<PosterModel> posters;
  final bool isLoadingMore;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: padding ?? AppSpacing.symmetric(vertical: 12, horizontal: AppSpacing.l),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .57,
              mainAxisSpacing: 15.h,
              crossAxisSpacing: 14.w,
              crossAxisCount: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PosterCard(
                  border: 10,
                  subCardBorder: 10,
                  mediaModel: posters[index],
                  elevation: 5,
                  maxLines: 2,
                  titleStyle: TextStyles.font11BoldIceBlueMontserrat.copyWith(
                    fontSize: 10.sp,
                  ),
                  subTextStyle: TextStyles.font11BoldIceBlueMontserrat.copyWith(
                    fontSize: 10.sp,
                  ),
                );
              },
              childCount: posters.length,
            ),
          ),
        ),
        if (isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.vertical(AppSpacing.xl),
              child: const Center(
                child: MovuraLoadingIndicator(size: 45),
              ),
            ),
          ),
      ],
    );
  }
}
