import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/money_formatter.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

import '../../../data/about_model.dart';

class AdditionalData extends StatelessWidget {
  const AdditionalData({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DataItem(label: "Status", value: "Released"), // Simplified
          _DataItem(
            label: "Language",
            value: model.language?.toUpperCase() ?? 'N/A',
          ),
          _DataItem(label: "Budget", value: (model.budget ?? 0).toSmartCurrency()),
          _DataItem(
            label: "Revenue",
            value: (model.revenue ?? 0).toSmartCurrency(),
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
      children: [
        Text(label, style: AppTextStyles.font10BoldCoolGray),
        verticalSpacing(4),
        Text(value, style: AppTextStyles.font12MediumPlatinumGray),
      ],
    );
  }
}
