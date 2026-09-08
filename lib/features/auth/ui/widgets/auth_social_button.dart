import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class AuthSocialButton extends StatefulWidget {
  const AuthSocialButton({
    super.key,
    required this.logoPath,
    required this.backgroundColor,
    required this.onTap,
  });

  final String logoPath;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  State<AuthSocialButton> createState() => _AuthSocialButtonState();
}

class _AuthSocialButtonState extends State<AuthSocialButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnim,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) => _scaleController.reverse(),
        onTapCancel: () => _scaleController.reverse(),
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: AppSpacing.all(12),
              decoration: BoxDecoration(
                color: widget.backgroundColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.pureWhite.withValues(alpha: 0.2),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.trueBlack.withValues(alpha: 0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                  if (_scaleController.value > 0.04)
                    BoxShadow(
                      color: AppColors.neonBlue.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Image.asset(
                widget.logoPath,
                width: 22.w,
                height: 22.h,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.account_circle_rounded,
                  color: AppColors.neonBlue,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
