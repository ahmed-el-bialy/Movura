import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/tv_models/about_tv_series_model.dart';

import '../../../../../../core/utils/constants/api_constants.dart';

class TvMainDetails extends StatelessWidget {
  const TvMainDetails({super.key, required this.model});

  final AboutTvSeriesModel model;

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


        ],
      ),
    );
  }
}
