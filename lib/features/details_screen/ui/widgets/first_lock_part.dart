import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/ui/widgets/short_review.dart';

import '../../../../core/networking/api_constants.dart';

class FirstLockPart extends StatelessWidget {
  const FirstLockPart({super.key, required this.model});

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
              fit: BoxFit.cover),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          ShortReview(model: model),
        ],
      ),
    );
  }
}
