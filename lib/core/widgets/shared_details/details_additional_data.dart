import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/spacing.dart';
import '../../theming/app_colors.dart';
import '../../theming/text_styles.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) => _DataItem(item: item)).toList(),
          ),
          if (bottomWidget != null) ...[
            verticalSpacing(20),
            bottomWidget!,
          ],
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
        verticalSpacing(6),
        Text(
          item.value,
          style: TextStyles.font12MediumPlatinumGray.copyWith(
            color: AppColors.iceBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
