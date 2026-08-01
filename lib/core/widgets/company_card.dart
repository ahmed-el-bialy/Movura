import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/models/company_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.company});

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          company.logo != null
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.pureWhite,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ApiConstants.imageBaseUrl}${company.logo!}",
                        fit: BoxFit.contain,
                        width: 140.w,
                        height: 130.w,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: AppColors.pureWhite),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.pureWhite,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiConstants.companyImageError,
                        fit: BoxFit.cover,
                        width: 140.w,
                        height: 130.w,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.villa_sharp,
                          color: AppColors.pureWhite,
                        ),
                      ),
                    ),
                  ),
                ),

          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 10.w,
              right: 10.w,
              bottom: 4.w,
            ),
            child: Text(
              company.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font13BoldNeonBlueSora.copyWith(fontSize: 14.sp),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 5.h,
              left: 10.w,
              right: 10.w,
              bottom: 8.w,
            ),
            child: Text(
              company.originCountry,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font11BoldIceBlueMontserrat.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
