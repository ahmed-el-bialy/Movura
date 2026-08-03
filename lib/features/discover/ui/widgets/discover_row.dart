import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import 'package:movura/core/widgets/layout/section_title.dart';

class DiscoverRow extends StatelessWidget {
  final String title;
  final List<PosterModel> items;
  final String mediaType;
  final VoidCallback onSeeAll;

  const DiscoverRow({
    super.key,
    required this.title,
    required this.items,
    required this.mediaType,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SectionTitle(
          sectionName: title,
          actionName: AppConstants.sectionAction,
          onTap: onSeeAll,
        ),
        AppSpacing.verticalSpacing(AppSpacing.s),
        SizedBox(
          height: 260.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 12.w : 0,
                  right: 12.w,
                  bottom: 12.h,
                  top: 4.h,
                ),
                child: PosterCard(
                  width: 170.w,
                  elevation: 8,
                  border: 15,
                  titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(fontSize: 13.sp),
                  mediaModel: items[index],
                  mediaType: mediaType,
                  showMediaType: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
