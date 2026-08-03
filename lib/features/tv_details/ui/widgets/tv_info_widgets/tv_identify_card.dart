import 'package:flutter/material.dart';
import '../../../../../../core/extensions/status_display_extension.dart';
import '../../../../../../core/widgets/shared_details/details_identify_card.dart';
import '../../../data/about_tv_series_model.dart';

class TvIdentifyCard extends StatelessWidget {
  const TvIdentifyCard({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    final String firstAirYear =
        (model.startAirDate != null && model.startAirDate!.length >= 4)
            ? model.startAirDate!.substring(0, 4)
            : '';

    final String statusStr = model.status?.statusDisplay ?? 'N/A';

    return DetailsIdentifyCard(
      title: model.title ?? 'Unknown',
      originalTitle: model.originalTitle,
      rating: model.rating ?? 0.0,
      tagline: model.tagline,
      typeLabel: "TV Series",
      year: firstAirYear,
      language: model.language ?? 'EN',
      status: statusStr,
      isAdult: model.adultContent ?? false,
    );
  }
}
