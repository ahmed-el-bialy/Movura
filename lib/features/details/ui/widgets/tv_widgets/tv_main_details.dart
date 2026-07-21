import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/tv_identify_card.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/extensions/routing_extension.dart';

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

          Positioned(
            top: 40.h,
            right: 16.w,
            child: SizedBox(
              width: 44.r,
              height: 44.r,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
                color: AppColors.onyxBlack.withValues(alpha: .9),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22.r),
                  splashColor: AppColors.neonBlue.withValues(alpha: .4),
                  onTap: () {},
                  child: Center(
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.neonBlue,
                      size: 22.r,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40.h,
            left: 16.w,
            child: SizedBox(
              width: 44.r,
              height: 44.r,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
                color: AppColors.onyxBlack.withValues(alpha: .95),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22.r),
                  splashColor: AppColors.neonBlue.withValues(alpha: .4),
                  onTap: () {
                    context.pop();
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.neonBlue,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          TvIdentifyCard(model: model),
        ],
      ),
    );
  }
}
