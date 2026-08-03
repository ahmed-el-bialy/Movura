import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/models/company_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.company});

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.all(6),
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
                      padding: AppSpacing.all(AppSpacing.s),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ApiConstants.imageBaseUrl}${company.logo!}",
                        fit: BoxFit.contain,
                        width: 140.w,
                        height: 130.w,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: AppColors.pureWhite,
                        ),
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
                      padding: AppSpacing.all(AppSpacing.s),
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
            padding: AppSpacing.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: AppSpacing.xs,
            ),
            child: Text(
              company.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font13BoldNeonBlueSora.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),

          Padding(
            padding: AppSpacing.only(
              top: 5,
              left: 10,
              right: 10,
              bottom: AppSpacing.s,
            ),
            child: Text(
              company.originCountry ?? '',
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
