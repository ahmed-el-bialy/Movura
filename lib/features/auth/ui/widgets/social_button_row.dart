import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import 'build_social_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuildSocialButton(
          logoPath: "assets/images/google_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () {},
        ),
        horizontalSpacing(12),
        BuildSocialButton(
          logoPath: "assets/images/facebook_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () {},
        ),
        horizontalSpacing(12),
        BuildSocialButton(
          logoPath: "assets/images/apple_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () {},
        ),
      ],
    );
  }
}
