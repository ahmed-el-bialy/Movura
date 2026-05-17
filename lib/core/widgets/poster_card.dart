import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home_screen/data/model/poster_model.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    this.height,
    this.width,
    this.shadowColor,
    this.elevation,
    this.titleStyle,
    this.subTextStyle,
    this.subCardElevation,
    this.border,
    this.poster,
    this.subCardColor, this.subCardBorder,
  });

  final double? height;
  final double? width;
  final Color? shadowColor;
  final double? elevation;
  final TextStyle? titleStyle;
  final TextStyle? subTextStyle;
  final double? subCardElevation;
  final Color? subCardColor;
  final double? border;
  final double? subCardBorder;
  final PosterModel? poster;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: shadowColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(border ?? 18),
      ),
      // color: AppColors.onyxBlack,
      child: SizedBox(
        width: width?.w ?? 220.w,
        height: height?.h ?? 310.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(border ?? 25),
              child: CachedNetworkImage(
                imageUrl:
                    "https://imgs.search.brave.com/0H0RkMW9Pb4WaQrpHAa-lxh0V4zWXrsbiJEh-3uk9yg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFjY1QxYkhCcUwu/anBn",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(2.0.r),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                          subCardBorder ?? 10)),
                  color: subCardColor ??
                      Color(0xFF2C2938).withValues(alpha: .6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.w, vertical: 4.w),
                    child: Text(
                      "Avengers : Age of Ultron",
                      style: titleStyle ?? Styles.font17IceBlueBoldMontserrat,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                          subCardBorder ?? 10)
                  ),
                  color: subCardColor ??
                      Color(0xFF2C2938).withValues(alpha: .6),
                elevation: subCardElevation ?? 10,
                child: Padding(
                  padding: EdgeInsets.all(5.0.r),
                  child: Text(
                    "Movie",
                    style: subTextStyle ?? Styles.font12platinumGraySimiBold,
                  ),
                ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Padding(
                padding: EdgeInsets.all(2.0.r),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                          subCardBorder ?? 10)),
                  color: subCardColor ??
                      Color(0xFF2C2938).withValues(alpha: .6),
                  elevation: subCardElevation ?? 10,
                  child: Padding(
                    padding: EdgeInsets.all(5.0.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${5.5}",
                          style: subTextStyle ??
                              Styles.font12platinumGraySimiBold,
                        ),
                        Icon(Icons.star_purple500_outlined, size: 18.sp,
                          color: subTextStyle?.color ??
                              Styles.font12platinumGraySimiBold.color,)
                      ],
                    ),
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
