import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/utils/extensions/runtime_formatter.dart';
import 'package:movura/core/utils/helpers/spacing.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

import '../../../../../core/utils/extensions/money_formatter.dart';

class AdditionalData extends StatelessWidget {
  const AdditionalData({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          SizedBox(
            height: 125.h,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "BUDGET",
                          style: Styles.font10MediumCoolGraySora
                              .copyWith(fontSize: 12.sp),
                        ),
                        Text(
                          model.budget != 0
                              ? model.budget.toSmartCurrency()
                              : "Unknown",
                          style: Styles.font15MediumWhite,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: AppColors.coolGray,
                    endIndent: 7.h,
                    indent: 7.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.trending_up_outlined,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "REVENUE",
                          style: Styles.font10MediumCoolGraySora
                              .copyWith(fontSize: 12.sp),
                        ),
                        Text(
                          model.revenue != 0
                              ? model.revenue.toSmartCurrency() : "Unknown",
                          style: Styles.font15MediumWhite,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: AppColors.coolGray,
                    endIndent: 7.h,
                    indent: 7.h,
                  ),
                  model.runtime != 0
                      ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "RUNTIME",
                          style: Styles.font10MediumCoolGraySora
                              .copyWith(fontSize: 12.sp),
                        ),

                        Text(
                          model.runtime.runtimeFormatter(),
                          style: Styles.font15MediumWhite,
                        ),
                      ],
                    ),
                  )

                      : horizontalSpacing(.5),

                  verticalSpacing(5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
