import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.richEerieBlack,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonBlue,
        secondary: AppColors.darkNeonCyan,
        surface: AppColors.eerieBlack,
        onSurface: AppColors.platinumGray,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.eerieBlack.withValues(alpha: 0.85),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.neonBlue),
        titleTextStyle: AppTextStyles.font20SimiBoldNeonBlueManrope,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.charcoalBlack,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.onyxBlack,
        contentTextStyle: AppTextStyles.font14PureWhiteManrope,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dividerColor: AppColors.slateGray.withValues(alpha: 0.3),
      splashColor: AppColors.neonBlue.withValues(alpha: 0.2),
      highlightColor: AppColors.neonBlue.withValues(alpha: 0.1),
    );
  }
}
