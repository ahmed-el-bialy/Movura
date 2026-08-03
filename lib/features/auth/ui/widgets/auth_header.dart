import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'hero_app_logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeroAppLogo(),
        verticalSpacing(5),
        Text(
          title,
          style: TextStyles.font40BoldPureWhite.copyWith(
            fontSize: 34.sp,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          subtitle,
          style: TextStyles.font12CoolGrayManrope.copyWith(
            fontSize: 14.sp,
            color: AppColors.slateGray.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
