import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/extensions/routing_extension.dart';
import '../../../../../core/widgets/app_icon_button.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/platform_options_sheet.dart';
import '../../../data/models/movie_models/about_model.dart';
import 'sub_widgets/movie_identify_card.dart';

class MovieMainDetails extends StatelessWidget {
  const MovieMainDetails({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: model.posterPath != null && model.posterPath!.isNotEmpty
                ? "${ApiConstants.imageBaseUrl}${model.posterPath}"
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
            child: Row(
              children: [
                if (model.homepage != null && model.homepage!.isNotEmpty)
                  AppIconButton(
                    icon: Icons.open_in_new_rounded,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => PlatformOptionsSheet(
                          homepageUrl: model.homepage!,
                          watchProviders: model.watchProviders,
                        ),
                      );
                    },
                    backgroundColor: AppColors.onyxBlack.withValues(alpha: .9),
                    size: 22,
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
                  onTap: () {
                    context.popToHomeOrGoHome();
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

          MovieIdentifyCard(model: model),
        ],
      ),
    );
  }
}