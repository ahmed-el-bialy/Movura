import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_icon_button.dart';
import 'package:movura/core/widgets/shared_details/platform_options_sheet.dart';

class CoreDetailsHeader extends StatelessWidget {
  const CoreDetailsHeader({
    super.key,
    required this.posterPath,
    required this.homepage,
    this.watchProviders,
    required this.identifyCard,
  });

  final String? posterPath;
  final String? homepage;
  final dynamic watchProviders;
  final Widget identifyCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: posterPath != null && posterPath!.isNotEmpty
                ? "${ApiConstants.imageBaseUrl}$posterPath"
                : "",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(color: AppColors.onyxBlack),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.trueBlack.withValues(alpha: 0.05),
                  AppColors.trueBlack.withValues(alpha: 0.1),
                  AppColors.trueBlack.withValues(alpha: 0.2),
                  AppColors.trueBlack,
                ],
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            right: 16.w,
            child: Row(
              children: [
                if ((homepage != null && homepage!.isNotEmpty) || (watchProviders?.results != null && watchProviders!.results!.isNotEmpty))
                  AppIconButton(
                    icon: Icons.play_circle_outline_rounded,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.transparent,
                        builder: (context) => PlatformOptionsSheet(
                          homepageUrl: homepage ?? '',
                          watchProviders: watchProviders,
                        ),
                      );
                    },
                    backgroundColor: AppColors.onyxBlack.withValues(alpha: .9),
                    size: 26,
                  ),
              ],
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
                  onTap: () => context.pop(),
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
          identifyCard,
        ],
      ),
    );
  }
}
