import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class AmbientSpheres extends StatelessWidget {
  const AmbientSpheres({super.key, required this.controller});

  final AnimationController controller;

  static const _colors = [
    AppColors.neonBlue,
    AppColors.darkNeonCyan,
    AppColors.electricBlueAccent,
    AppColors.tealCyan,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List.generate(4, (i) {
        final color = _colors[i];
        final size = (280 + i * 50).r;
        final alpha = 0.20 - (i * 0.02);

        return Animate(
          onPlay: (c) => c.repeat(reverse: true),
          effects: [
            CustomEffect(
              duration: (14 + i * 4).seconds,
              curve: Curves.easeInOutSine,
              builder: (ctx, value, _) {
                final t = value * 2 * math.pi;
                final pos = _spherePosition(i, t);
                return Align(
                  alignment: pos,
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
      }),
    );
  }

  Alignment _spherePosition(int i, double t) {
    return switch (i) {
      0 => Alignment(-0.7 + 0.3 * math.sin(t), -0.6 + 0.2 * math.cos(t)),
      1 => Alignment(0.7 + 0.25 * math.cos(t * 1.1), 0.6 + 0.3 * math.sin(t)),
      2 => Alignment(
        0.3 + 0.35 * math.sin(t * 0.8 + 1),
        -0.2 + 0.25 * math.cos(t * 1.2),
      ),
      _ => Alignment(
        -0.4 + 0.3 * math.cos(t * 0.9 + 2),
        0.65 + 0.2 * math.sin(t * 1.3),
      ),
    };
  }
}
