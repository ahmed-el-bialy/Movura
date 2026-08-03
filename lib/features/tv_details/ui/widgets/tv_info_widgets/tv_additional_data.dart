import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../data/about_tv_series_model.dart';

class TvAdditionalData extends StatelessWidget {
  const TvAdditionalData({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DataItem(label: "Status", value: model.status ?? 'N/A'),
          _DataItem(
            label: "Language",
            value: model.language?.toUpperCase() ?? 'N/A',
          ),
          _DataItem(
            label: "Seasons",
            value: model.numberOfSeasons?.toString() ?? '0',
          ),
          _DataItem(
            label: "Episodes",
            value: model.numberOfEpisodes?.toString() ?? '0',
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
        Text(label, style: TextStyles.font10BoldCoolGray),
        verticalSpacing(4),
        Text(value, style: TextStyles.font12MediumPlatinumGray),
      ],
    );
  }
}
