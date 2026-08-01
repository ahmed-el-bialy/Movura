import 'package:flutter/material.dart';
import 'package:movura/core/widgets/shared_details/core_details_header.dart';
import 'package:movura/features/movie_details/data/models/about_model.dart';
import 'package:movura/features/movie_details/ui/widgets/sub_widgets/movie_identify_card.dart';

class MovieMainDetails extends StatelessWidget {
  const MovieMainDetails({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return CoreDetailsHeader(
      posterPath: model.posterPath,
      homepage: model.homepage,
      watchProviders: model.watchProviders,
      identifyCard: MovieIdentifyCard(model: model),
    );
  }
}
