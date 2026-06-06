import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movura/features/details_screen/data/models/tv_models/about_tv_series_model.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/tv_main_details.dart';

class TvScreenBody extends StatelessWidget {
  const TvScreenBody({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    String? trailerKey;
    final videos = model.tvVideos?.videoList;

    if (videos != null && videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (v) => v.type.toLowerCase() == 'trailer',
        orElse: () => videos.first,
      );
      trailerKey = trailer.key;
      if (kDebugMode) {
        print("this is the trailer kay: $trailerKey");
      }
    } else {
      if (kDebugMode) {
        print("trailer not exist");
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [TvMainDetails(model: model)],
    );
  }
}
