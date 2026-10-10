import 'package:flutter/material.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class ProfileSectionHeader extends StatelessWidget {
  const ProfileSectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.font10BoldCoolGray.copyWith(
        letterSpacing: 1.5,
        color: AppColors.neonBlue.withValues(alpha: 0.7),
      ),
    );
  }
}
