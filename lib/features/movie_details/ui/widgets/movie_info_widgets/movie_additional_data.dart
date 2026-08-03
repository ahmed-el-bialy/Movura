import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/money_formatter.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/shared_details/details_additional_data.dart';
import '../../../data/models/about_model.dart';

class AdditionalData extends StatelessWidget {
  const AdditionalData({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    final int budget = model.budget ?? 0;
    final int revenue = model.revenue ?? 0;
    final int profit = revenue - budget;
    final bool isProfit = profit >= 0;

    return DetailsAdditionalData(
      items: [
        DetailsDataItem(label: "STATUS", value: model.status ?? "Released"),
        DetailsDataItem(
          label: "LANGUAGE",
          value: model.language?.toUpperCase() ?? 'N/A',
        ),
        DetailsDataItem(label: "BUDGET", value: budget.toSmartCurrency()),
        DetailsDataItem(label: "REVENUE", value: revenue.toSmartCurrency()),
      ],
      bottomWidget: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isProfit
                  ? Colors.greenAccent.withValues(alpha: 0.08)
                  : AppColors.softRed.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isProfit
                    ? Colors.greenAccent.withValues(alpha: 0.2)
                    : AppColors.softRed.withValues(alpha: 0.2),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isProfit
                      ? Icons.auto_graph_rounded
                      : Icons.trending_down_rounded,
                  color: isProfit ? Colors.greenAccent : AppColors.softRed,
                  size: 20.sp,
                ),
                horizontalSpacing(12),
                Text(
                  isProfit ? "ESTIMATED PROFIT: " : "ESTIMATED LOSS: ",
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    color: isProfit ? Colors.greenAccent : AppColors.softRed,
                    letterSpacing: 1.1,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  profit.abs().toSmartCurrency(),
                  style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
