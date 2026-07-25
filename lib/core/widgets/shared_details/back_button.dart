import 'package:flutter/material.dart';

import 'package:movura/core/theming/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.jetBlack.withValues(alpha: 0.82),
          border: Border.all(
            color: AppColors.neonBlue.withValues(alpha: 0.9),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonBlue..withValues(alpha: 0.35),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.neonBlue,
          size: 22,
        ),
      ),
    );
  }
}
