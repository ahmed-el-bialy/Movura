import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/api_constants.dart';
import '../../models/image_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import '../../theming/app_spacing.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.images,
    this.imageFit = BoxFit.cover,
    this.height = 230,
    this.verPadding,
    this.herPadding,
    this.imageWidth,
  });

  final List<ImageModel> images;
  final BoxFit imageFit;
  final double height;
  final double? imageWidth;
  final double? verPadding;
  final double? herPadding;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: height.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: AppSpacing.all(AppSpacing.s),
            child: Card(
              elevation: 5,
              shadowColor: AppColors.slateGray,
              child: imageWidth != null
                  ? SizedBox(
                      width: imageWidth!.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: AppSpacing.symmetric(
                            horizontal: herPadding ?? 0,
                            vertical: verPadding ?? 0,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiConstants.imageBaseUrl}${images[index].imagePath}",
                            fit: imageFit,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: AppSpacing.symmetric(
                          horizontal: herPadding ?? 0,
                          vertical: verPadding ?? 0,
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${ApiConstants.imageBaseUrl}${images[index].imagePath}",
                          fit: imageFit,
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
