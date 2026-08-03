import 'package:flutter/material.dart';

import '../../../../../core/widgets/shared_details/details_identify_card.dart';
import '../../../data/models/about_model.dart';

class MovieIdentifyCard extends StatelessWidget {
  const MovieIdentifyCard({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    final String releaseYear =
        (model.releaseDate != null && model.releaseDate!.length >= 4)
            ? model.releaseDate!.substring(0, 4)
            : (model.status ?? 'Released');

    return DetailsIdentifyCard(
      title: model.title ?? 'Unknown',
      originalTitle: model.originalTitle,
      rating: model.rating ?? 0.0,
      tagline: model.tagline,
      typeLabel: "Movie",
      year: releaseYear,
      language: model.language ?? 'EN',
      isAdult: model.adultContent ?? false,
    );
  }
}
