import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

class TvSeasonCard extends StatelessWidget {
  const TvSeasonCard({super.key, required this.tvSeasonModel});

  final TvSeasonModel tvSeasonModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 8,
        shadowColor: AppColors.neonCyan,
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
                      Container(color: const Color(0xFF2C2938)),
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
                    color: Color(0xFF2C2938).withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 4.w,
                      ),
                      child: Text(
                        tvSeasonModel.name,
                        style: Styles.font17BoldIceBlueMontserrat.copyWith(
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
                    color: Color(0xFF2C2938).withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Text(
                        "${tvSeasonModel.episodeCount} Eps",
                        style: Styles.font16SimiBoldPlatinumGray.copyWith(
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
                  padding: EdgeInsets.all(4.0).r,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xFF2C2938).withValues(alpha: .9),
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
                            style: Styles.font16SimiBoldPlatinumGray.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                          Icon(
                            Icons.star_purple500_outlined,
                            size: 15.sp,
                            color: Styles.font16SimiBoldPlatinumGray.color,
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
