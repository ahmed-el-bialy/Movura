import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../core/constants/api_constants.dart';
import '../../data/about_tv_series_model.dart';

class TvSeasonCard extends StatelessWidget {
  const TvSeasonCard({
    super.key,
    required this.tvSeasonModel,
    required this.onTap,
  });

  final TvSeasonModel tvSeasonModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: AppColors.neonBlue,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  imageUrl:
                      (tvSeasonModel.posterPath != null &&
                          tvSeasonModel.posterPath!.isNotEmpty)
                      ? "${ApiConstants.imageBaseUrl}${tvSeasonModel.posterPath}"
                      : "",
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Container(color: AppColors.darkPurpleGray),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 8,
                    color: AppColors.darkPurpleGray.withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 4.w,
                      ),
                      child: Text(
                        tvSeasonModel.name ?? "",
                        style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                          fontSize: 15.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColors.darkPurpleGray.withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Text(
                        "${tvSeasonModel.episodeCount ?? 0} Eps",
                        style: TextStyles.font16SemiBoldPlatinumGray.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0).r,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColors.darkPurpleGray.withValues(alpha: .9),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tvSeasonModel.voteAverage != null
                                ? "${tvSeasonModel.voteAverage!.toStringAsFixed(1)} "
                                : "0.0",
                            style: TextStyles.font16SemiBoldPlatinumGray
                                .copyWith(fontSize: 13.sp),
                          ),
                          Icon(
                            Icons.star_purple500_outlined,
                            size: 15.sp,
                            color: TextStyles.font16SemiBoldPlatinumGray.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
