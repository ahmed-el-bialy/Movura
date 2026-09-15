import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

/// Ultra-modern cinematic background with orbiting glowing light spheres,
/// a rotating floating Movura logo watermark, and deep backdrop blur for Auth screens.
/// Refactored to use flutter_animate for high-performance cinematic motion.
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, this.isSignUp = false});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base dark background
        Container(color: AppColors.richEerieBlack),

        // 4 Dynamic Orbiting Glowing Spheres
        ..._buildSpheres(),

        // Animated Watermark Movura Logo in Background
        _buildWatermark(),

        // Deep Gaussian Blur overlay for glowing bokeh effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 75, sigmaY: 70),
            child: Container(
              color: AppColors.richEerieBlack.withValues(alpha: 0.25),
            ),
          ),
        ),

        // Gradient vignetting around edges
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  AppColors.trueBlack.withValues(alpha: 0.7),
                ],
                radius: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSpheres() {
    final colors = [
      AppColors.neonBlue,
      AppColors.darkNeonCyan,
      AppColors.electricBlueAccent,
      AppColors.tealCyan,
    ];

    return List.generate(4, (index) {
      final color = colors[index];
      final size = (300 + (index * 40)).r;
      final alpha = 0.22 - (index * 0.02);

      return Animate(
        onPlay: (controller) => controller.repeat(reverse: true),
        effects: [
          CustomEffect(
            duration: (12 + index * 3).seconds,
            curve: Curves.easeInOutSine,
            builder: (context, value, child) {
              final t = value * 2 * math.pi;
              double x, y;
              if (index == 0) {
                x = -0.6 + 0.35 * math.sin(t);
                y = -0.5 + 0.25 * math.cos(t * 0.8);
              } else if (index == 1) {
                x = 0.65 + 0.3 * math.cos(t * 1.1);
                y = 0.55 + 0.35 * math.sin(t * 0.9);
              } else if (index == 2) {
                x = 0.4 + 0.4 * math.sin(t * 0.7 + 1.0);
                y = -0.2 + 0.3 * math.cos(t * 1.2 + 0.5);
              } else {
                x = -0.5 + 0.3 * math.cos(t * 0.9 + 2.0);
                y = 0.6 + 0.25 * math.sin(t * 1.3 + 1.5);
              }

              return Align(
                alignment: Alignment(x, y),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withValues(alpha: alpha),
                        color.withValues(alpha: alpha * 0.4),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildWatermark() {
    return Image.asset(
          'assets/images/app_icon_1024.png',
          width: 320.r,
          height: 320.r,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.movie_creation_rounded,
            size: 250.r,
            color: AppColors.neonBlue,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 40.seconds, end: 1.0)
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          duration: 5.seconds,
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.1, 1.1),
          curve: Curves.easeInOut,
        )
        .animate()
        .fadeIn(duration: 2.seconds)
        .tint(color: AppColors.neonBlue, end: 0.05);
  }
}
