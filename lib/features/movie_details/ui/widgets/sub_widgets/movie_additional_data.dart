import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/money_formatter.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DataItem(label: "STATUS", value: model.status ?? "Released"),
              _DataItem(
                label: "LANGUAGE",
                value: model.language?.toUpperCase() ?? 'N/A',
              ),
              _DataItem(label: "BUDGET", value: budget.toSmartCurrency()),
              _DataItem(label: "REVENUE", value: revenue.toSmartCurrency()),
            ],
          ),
          verticalSpacing(20),
          ClipRRect(
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
                        color: isProfit
                            ? Colors.greenAccent
                            : AppColors.softRed,
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
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  const _DataItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 0.8,
            fontSize: 9.sp,
            color: AppColors.coolGray.withValues(alpha: 0.8),
          ),
        ),
        verticalSpacing(6),
        Text(
          value,
          style: TextStyles.font12MediumPlatinumGray.copyWith(
            color: AppColors.iceBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
