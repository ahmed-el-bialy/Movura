import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DetailsAdditionalData extends StatelessWidget {
  const DetailsAdditionalData({
    super.key,
    required this.items,
    this.bottomWidget,
  });

  final List<DetailsDataItem> items;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) => _DataItem(item: item)).toList(),
          ),
          if (bottomWidget != null) ...[AppSpacing.verticalSpacing(20), bottomWidget!],
        ],
      ),
    );
  }
}

class DetailsDataItem {
  final String label;
  final String value;
  const DetailsDataItem({required this.label, required this.value});
}

class _DataItem extends StatelessWidget {
  const _DataItem({required this.item});

  final DetailsDataItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.label.toUpperCase(),
          style: TextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 0.8,
            fontSize: 9.sp,
            color: AppColors.coolGray.withValues(alpha: 0.8),
          ),
        ),
        AppSpacing.verticalSpacing(6),
        Text(
          item.value,
          style: TextStyles.font12MediumPlatinumGray.copyWith(
            color: AppColors.iceBlue,
            fontWeight: Weights.bold,
          ),
        ),
      ],
    );
  }
}
