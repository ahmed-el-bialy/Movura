import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import 'package:movura/features/library/ui/widgets/library_empty_state.dart';

class LibraryTabContent extends StatelessWidget {
  const LibraryTabContent({
    super.key,
    required this.title,
    required this.emptyIcon,
    required this.items,
  });

  final String title;
  final IconData emptyIcon;
  final List<PosterModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return LibraryEmptyState(title: title, icon: emptyIcon);
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppSpacing.all(AppSpacing.l),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PosterCard(
          mediaModel: item,
          mediaType: item.mediaType,
          elevation: 6,
          width: double.infinity,
          height: double.infinity,
          border: 12,
          titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(
            fontSize: 11.sp,
            fontWeight: Weights.extraBold,
          ),
          subTextStyle: TextStyles.font16SemiBoldPlatinumGray.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
          ),
          showMediaType: true,
          maxLines: 2,
        );
      },
    );
  }
}
