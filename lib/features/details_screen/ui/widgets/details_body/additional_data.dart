import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/spacing.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

import '../../../../../core/helper/number_formatter.dart';
import '../../../../../core/theming/colors.dart';

class AdditionalData extends StatelessWidget {
  const AdditionalData({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Card(
        color: AppColors.onyxBlack.withValues(alpha: .7),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: (model.budget != 0)
                  ? Row(
                      children: [
                        Text(
                          "BUDGET",
                          style: Styles.font14SimiBoldPlatinumGraySora,
                        ),
                        Spacer(flex: 1),
                        Text(
                          model.budget.toFullCurrency(),
                          style: Styles.font13BoldNeonCyanSora,
                        ),
                      ],
                    )
                  : verticalSpacing(.5),
            ),
            (model.budget != 0)
                ? Divider(color: AppColors.slateGray.withValues(alpha: .5))
                : verticalSpacing(.5),
            model.revenue != 0
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "REVENUE",
                          style: Styles.font14SimiBoldPlatinumGraySora,
                        ),
                        Spacer(flex: 1),
                        Text(
                          model.revenue.toFullCurrency(),
                          style: Styles.font13BoldNeonCyanSora,
                        ),
                      ],
                    ),
                  )
                : verticalSpacing(.5),
            (model.revenue != 0)
                ? Divider(color: AppColors.slateGray.withValues(alpha: .5))
                : verticalSpacing(1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    "ADULT CONTENT",
                    style: Styles.font14SimiBoldPlatinumGraySora,
                  ),
                  Spacer(flex: 1),
                  Text(
                    "${model.adultContent}",
                    style: Styles.font13BoldNeonCyanSora,
                  ),
                ],
              ),
            ),
            verticalSpacing(5),
          ],
        ),
      ),
    );
  }
}
