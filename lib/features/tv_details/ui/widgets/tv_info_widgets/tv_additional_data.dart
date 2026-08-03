import 'package:flutter/material.dart';
import 'package:movura/core/widgets/shared_details/details_additional_data.dart';
import '../../../data/about_tv_series_model.dart';

class TvAdditionalData extends StatelessWidget {
  const TvAdditionalData({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return DetailsAdditionalData(
      items: [
        DetailsDataItem(label: "Status", value: model.status ?? 'N/A'),
        DetailsDataItem(
          label: "Language",
          value: model.language?.toUpperCase() ?? 'N/A',
        ),
        DetailsDataItem(
          label: "Seasons",
          value: model.numberOfSeasons?.toString() ?? '0',
        ),
        DetailsDataItem(
          label: "Episodes",
          value: model.numberOfEpisodes?.toString() ?? '0',
        ),
      ],
    );
  }
}
