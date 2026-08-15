import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import '../../logic/auth/auth_cubit.dart';
import 'auth_social_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthSocialButton(
          logoPath: "assets/images/google_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () => context.read<AuthCubit>().signInWithGoogle(),
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        AuthSocialButton(
          logoPath: "assets/images/facebook_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () => context.read<AuthCubit>().signInWithFacebook(),
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        AuthSocialButton(
          logoPath: "assets/images/apple_logo.png",
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.6),
          onTap: () => context.read<AuthCubit>().signInWithApple(),
        ),
      ],
    );
  }
}
