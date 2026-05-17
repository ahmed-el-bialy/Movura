import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/weights.dart';

class Styles {
  static TextStyle font24NeonCyanSimiBoldManrope = TextStyle(
    fontWeight: Weights.simiBold,
    color: AppColors.neonCyan,
    fontSize: 24.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font17IceBlueBoldMontserrat = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.iceBlue,
    fontSize: 17.sp,
    fontFamily: "Montserrat",
  );
  static TextStyle font14IceBlueBoldMontserrat = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.iceBlue,
    fontSize: 14.sp,
    fontFamily: "Montserrat",
  );
  static TextStyle font11IGoldBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    fontSize: 11.sp,
  );

  static TextStyle font10NeonCyanMedium = TextStyle(
    fontWeight: Weights.medium,
    color: AppColors.neonCyan,
    fontSize: 13.sp,
  );
  static TextStyle font20platinumGraySimiBold = TextStyle(
    fontWeight: Weights.simiBold,
    color: AppColors.platinumGray,
    fontSize: 20.sp,
  );
  static TextStyle font12platinumGraySimiBold = TextStyle(
    fontWeight: Weights.simiBold,
    color: AppColors.platinumGray,
    fontSize: 16.sp,
  );
}
