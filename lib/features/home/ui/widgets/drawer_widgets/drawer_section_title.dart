import 'package:flutter/material.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DrawerSectionTitle extends StatelessWidget {
  const DrawerSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.only(
        left: AppSpacing.l,
        top: AppSpacing.xl,
        right: AppSpacing.l,
        bottom: AppSpacing.s,
      ),
      child: Text(
        title,
        style: TextStyles.font10BoldCoolGray.copyWith(
          color: AppColors.neonBlue.withValues(alpha: 0.5),
          letterSpacing: 2,
          fontWeight: Weights.black,
        ),
      ),
    );
  }
}
