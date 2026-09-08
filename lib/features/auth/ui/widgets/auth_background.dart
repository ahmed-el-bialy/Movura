import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class AuthBackground extends StatefulWidget {
  const AuthBackground({super.key, this.isSignUp = false});

  final bool isSignUp;

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base dark color
        Positioned.fill(
          child: Container(
            color: AppColors.trueBlack,
          ),
        ),

        // Animated Moving Blobs - 4 blobs for a more unique feel
        ...List.generate(4, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final val = _controller.value;
              double x, y;
              
              if (index == 0) {
                x = -0.7 + (0.4 * val);
                y = -0.5 + (0.3 * val);
              } else if (index == 1) {
                x = 0.7 - (0.5 * val);
                y = 0.6 + (0.2 * val);
              } else if (index == 2) {
                x = 0.4 + (0.6 * val);
                y = -0.3 - (0.4 * val);
              } else {
                x = -0.5 - (0.3 * val);
                y = 0.8 - (0.5 * val);
              }

              final color = index == 0 
                  ? AppColors.neonBlue 
                  : index == 1 
                      ? AppColors.vibrantPurple 
                      : index == 2 
                          ? AppColors.electricBlueAccent 
                          : AppColors.tealCyan;

              return Align(
                alignment: Alignment(x, y),
                child: Container(
                  width: (350 + (index * 40)).r,
                  height: (350 + (index * 40)).r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),

        // Deep Gaussian Blur for "Premium" atmosphere
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.trueBlack.withValues(alpha: 0.25),
              ),
            ),
          ),
        ),
        
        // Subtle Noise or Grain (could be added here if we had an asset)
      ],
    );
  }
}
