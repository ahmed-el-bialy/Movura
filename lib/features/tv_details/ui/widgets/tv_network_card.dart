import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/constants/api_constants.dart';
import '../../data/about_tv_series_model.dart';

class TvNetworkCard extends StatelessWidget {
  const TvNetworkCard({super.key, required this.network});

  final TvNetworkModel network;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.slateGray.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: network.logo != null
                ? CachedNetworkImage(
                    imageUrl: "${ApiConstants.imageBaseUrl}${network.logo}",
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(
                      Icons.tv,
                      color: AppColors.pureWhite.withValues(alpha: 0.7),
                    ),
                  )
                : Icon(
                    Icons.tv,
                    color: AppColors.pureWhite.withValues(alpha: 0.7),
                  ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.s),
          Text(
            network.name ?? 'Network',
            style: TextStyles.font10BoldCoolGray.copyWith(fontSize: 12.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
