import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';

import '../theming/colors.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    this.height,
    this.width,
    this.shadowColor,
    this.elevation,
    this.titleStyle,
    this.typeStyle,
    this.subCardElevation,
  });

  final double? height;
  final double? width;
  final Color? shadowColor;
  final double? elevation;
  final TextStyle? titleStyle;
  final TextStyle? typeStyle;
  final double? subCardElevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor ?? Colors.white,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(25),
      ),
      color: AppColors.onyxBlack,
      child: SizedBox(
        width: width?.w ?? 220.w,
        height: height?.h ?? 310.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: CachedNetworkImage(
                imageUrl:
                    "https://imgs.search.brave.com/0H0RkMW9Pb4WaQrpHAa-lxh0V4zWXrsbiJEh-3uk9yg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFjY1QxYkhCcUwu/anBn",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: Text(
                  "Neon Horizon",
                  style: titleStyle ?? Styles.font24NeonCyanSimiBoldManrope,
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Card(
                color: Color(0xFF2C2938),
                elevation: subCardElevation ?? 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Text(
                    "Movie",
                    style: typeStyle ?? Styles.font12platinumGraySimiBold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Card(
                color: Color(0xFF2C2938),
                elevation: subCardElevation ?? 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Text(
                    "${5.5}",
                    style: typeStyle ?? Styles.font12platinumGraySimiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
