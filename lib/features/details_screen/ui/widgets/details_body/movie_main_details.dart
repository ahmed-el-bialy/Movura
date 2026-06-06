import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants/api_constants.dart';
import '../../../data/models/movie_models/about_model.dart';
import 'identification_card.dart';

class MovieMainDetails extends StatelessWidget {
  const MovieMainDetails({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}${model.posterPath}",
            fit: BoxFit.cover,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black,
                ],
              ),
            ),
          ),

          IdentificationCard(model: model),
        ],
      ),
    );
  }
}
