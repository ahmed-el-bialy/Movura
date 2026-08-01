import 'package:flutter/material.dart';
import 'package:movura/core/widgets/shared_details/core_details_header.dart';
import 'package:movura/features/tv_details/data/about_tv_series_model.dart';
import 'package:movura/features/tv_details/ui/widgets/sub_widgets/tv_identify_card.dart';

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
