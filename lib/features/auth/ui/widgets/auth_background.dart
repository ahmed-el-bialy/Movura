import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, this.isSignUp = false});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: isSignUp ? Alignment.topRight : Alignment.topLeft,
                end: isSignUp ? Alignment.bottomLeft : Alignment.bottomRight,
                colors: [
                  if (!isSignUp) ...[
                    AppColors.trueBlack,
                    AppColors.trueBlack,
                    AppColors.trueBlack,
                  ],
                  AppColors.neonBlue.withValues(alpha: 0.5),
                  AppColors.neonBlue.withValues(alpha: 0.4),
                  AppColors.neonBlue.withValues(alpha: 0.5),
                  AppColors.trueBlack,
                  AppColors.trueBlack,
                  AppColors.charcoalBlack,
                ],
              ),
            ),
          ),
        ),
        if (!isSignUp)
          Positioned(
            top: -50.h,
            right: -50.w,
            child: Container(
              width: 200.r,
              height: 200.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.neonBlue.withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: AppColors.transparent),
              ),
            ),
          ),
      ],
    );
  }
}
