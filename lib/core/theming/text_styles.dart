import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/weights.dart';

import 'package:movura/core/theming/app_colors.dart';

abstract class TextStyles {
  static TextStyle font24SemiBoldNeonBlueManrope = TextStyle(
    fontWeight: Weights.semiBold,
    color: AppColors.neonBlue,
    fontSize: 24.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font20SemiBoldNeonBlueManrope = TextStyle(
    fontWeight: Weights.semiBold,
    color: AppColors.neonBlue,
    fontSize: 20.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font14RegularDarkNeonBlueManrope = TextStyle(
    fontWeight: Weights.regular,
    color: AppColors.darkNeonCyan,
    fontSize: 14.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font14RegularPureWhiteManrope = TextStyle(
    fontWeight: Weights.regular,
    color: AppColors.pureWhite,
    fontSize: 14.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font12RegularCoolGrayManrope = TextStyle(
    fontWeight: Weights.regular,
    color: AppColors.coolGray,
    fontSize: 12.sp,
    fontFamily: "Manrope",
  );

  static TextStyle font17BoldIceBlueMontserrat = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.iceBlue,
    fontSize: 17.sp,
    fontFamily: "Montserrat",
  );

  static TextStyle font11BoldIceBlueMontserrat = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.iceBlue,
    fontSize: 11.sp,
    fontFamily: "Montserrat",
  );

  static TextStyle font14BoldIceBlueMontserrat = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.iceBlue,
    fontSize: 14.sp,
    fontFamily: "Montserrat",
  );

  static TextStyle font17BoldTrueBlackSora = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.trueBlack,
    fontSize: 17.sp,
    fontFamily: "Sora",
  );

  static TextStyle font13BoldNeonBlueSora = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.neonBlue,
    fontSize: 13.sp,
    fontFamily: "Sora",
  );

  static TextStyle font10MediumCoolGraySora = TextStyle(
    fontWeight: Weights.medium,
    color: AppColors.coolGray,
    fontSize: 10.sp,
    fontFamily: "Sora",
  );

  static TextStyle font14SemiBoldPlatinumGraySora = TextStyle(
    fontWeight: Weights.semiBold,
    color: AppColors.platinumGray,
    fontSize: 14.sp,
    fontFamily: "Sora",
  );

  static TextStyle font20SemiBoldPlatinumGray = TextStyle(
    fontWeight: Weights.semiBold,
    color: AppColors.platinumGray,
    fontSize: 20.sp,
  );

  static TextStyle font13MediumNeonBlue = TextStyle(
    fontWeight: Weights.medium,
    color: AppColors.neonBlue,
    fontSize: 13.sp,
  );

  static TextStyle font15MediumWhite = TextStyle(
    fontWeight: Weights.medium,
    color: AppColors.pureWhite,
    fontSize: 15.sp,
  );

  static TextStyle font16SemiBoldPlatinumGray = TextStyle(
    fontWeight: Weights.semiBold,
    color: AppColors.platinumGray,
    fontSize: 16.sp,
  );

  static TextStyle font12BoldCoolGray = TextStyle(
    color: AppColors.coolGray,
    fontSize: 12.sp,
    fontWeight: Weights.bold,
  );

  static TextStyle font12MediumPlatinumGray = TextStyle(
    fontWeight: Weights.medium,
    color: AppColors.platinumGray,
    fontSize: 12.sp,
  );

  static TextStyle font11BoldGold = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.gold,
    fontSize: 11.sp,
  );

  static TextStyle font10BoldCoolGray = TextStyle(
    fontWeight: Weights.bold,
    color: AppColors.coolGray,
    fontSize: 10.sp,
  );

  static TextStyle font40BoldPureWhite = TextStyle(
    color: AppColors.pureWhite,
    fontSize: 40.sp,
    fontWeight: Weights.bold,
  );
}
