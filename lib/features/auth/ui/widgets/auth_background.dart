import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

/// Ultra-modern cinematic background with orbiting glowing light spheres,
/// smooth sinusoidal motion, and deep backdrop blur for Auth screens.
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
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base dark background
        Container(color: AppColors.richEerieBlack),

        // 4 Dynamic Orbiting Glowing Spheres
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value * 2 * math.pi;

            // Sphere 1: Top-Left Neon Blue
            final x1 = -0.6 + 0.35 * math.sin(t);
            final y1 = -0.5 + 0.25 * math.cos(t * 0.8);

            // Sphere 2: Bottom-Right Vibrant Purple
            final x2 = 0.65 + 0.3 * math.cos(t * 1.1);
            final y2 = 0.55 + 0.35 * math.sin(t * 0.9);

            // Sphere 3: Center-Right Electric Blue Accent
            final x3 = 0.4 + 0.4 * math.sin(t * 0.7 + 1.0);
            final y3 = -0.2 + 0.3 * math.cos(t * 1.2 + 0.5);

            // Sphere 4: Bottom-Left Teal Cyan
            final x4 = -0.5 + 0.3 * math.cos(t * 0.9 + 2.0);
            final y4 = 0.6 + 0.25 * math.sin(t * 1.3 + 1.5);

            final spheres = [
              (x1, y1, AppColors.neonBlue, 340.r, 0.24),
              (x2, y2, AppColors.darkNeonCyan, 380.r, 0.22),
              (x3, y3, AppColors.electricBlueAccent, 300.r, 0.20),
              (x4, y4, AppColors.tealCyan, 320.r, 0.18),
            ];

            return Stack(
              children: spheres.map((s) {
                return Align(
                  alignment: Alignment(s.$1, s.$2),
                  child: Container(
                    width: s.$4,
                    height: s.$4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          s.$3.withValues(alpha: s.$5),
                          s.$3.withValues(alpha: s.$5 * 0.4),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),

        // Deep Gaussian Blur overlay for glowing bokeh effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
            child: Container(
              color: AppColors.richEerieBlack.withValues(alpha: 0.35),
            ),
          ),
        ),

        // Subtle gradient vignetting around edges
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  AppColors.trueBlack.withValues(alpha: 0.6),
                ],
                radius: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
