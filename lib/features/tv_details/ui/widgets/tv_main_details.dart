import 'package:flutter/material.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_info_widgets/tv_identify_card.dart';

import '../../../../core/widgets/shared_details/core_details_header.dart';
import '../../data/about_tv_series_model.dart';

class TvMainDetails extends StatelessWidget {
  const TvMainDetails({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return CoreDetailsHeader(
      posterPath: model.posterPath,
      homepage: model.homepage,
      watchProviders: model.watchProviders,
      identifyCard: TvIdentifyCard(model: model),
    );
  }
}
