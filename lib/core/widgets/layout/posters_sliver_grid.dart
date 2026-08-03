import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import '../../theming/text_styles.dart';

class PostersSliverGrid extends StatelessWidget {
  const PostersSliverGrid({
    super.key,
    required this.posters,
    this.isLoadingMore = false,
  });

  final List<PosterModel> posters;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverGrid(
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
        if (isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: const Center(
                child: MovuraLoadingIndicator(size: 45),
              ),
            ),
          ),
      ],
    );
  }
}
