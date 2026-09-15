import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

/// Next-Gen Cinematic Splash Screen for Movura
/// Features: Continuous fluid laser orbit canvas around logo, pure neon blue & eerie black palette,
/// staggered text reveal using flutter_animate, and seamless authentication routing.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;

  @override
  void initState() {
    super.initState();

    // Continuous 360-degree laser orbit controller
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3200));
    if (!mounted) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      final targetRoute =
          user != null ? RouteNames.mainScreen : RouteNames.logInScreen;

      if (mounted) {
        context.pushAndRemoveUntil(routeName: targetRoute);
      }
    } catch (_) {
      if (mounted) {
        context.pushAndRemoveUntil(routeName: RouteNames.logInScreen);
      }
    }
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background ambient pulse
          Animate(
            onPlay: (controller) => controller.repeat(reverse: true),
            effects: [
              CustomEffect(
                duration: 3.seconds,
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  final pulse = 0.14 + (0.08 * value);
                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          AppColors.neonBlue.withValues(alpha: pulse),
                          AppColors.darkNeonCyan.withValues(alpha: pulse * 0.4),
                          AppColors.richEerieBlack,
                        ],
                        center: Alignment.center,
                        radius: 1.2,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // Main splash logo with dynamic orbiting laser canvas
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170.r,
                height: 170.r,
                child: AnimatedBuilder(
                  animation: _orbitController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _CinematicOrbitPainter(
                        progress: _orbitController.value,
                        color: AppColors.neonBlue,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/app_icon_1024.png',
                          width: 95.w,
                          height: 95.h,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.play_circle_fill_rounded,
                            size: 80.sp,
                            color: AppColors.neonBlue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  .animate()
                  .fade(duration: 800.ms, curve: Curves.easeIn)
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    end: const Offset(1.0, 1.0),
                    duration: 1000.ms,
                    curve: Curves.easeOutBack,
                  )
                  .shimmer(
                    delay: 1200.ms,
                    duration: 1800.ms,
                    color: AppColors.neonBlue.withValues(alpha: 0.2),
                  ),

              AppSpacing.verticalSpacing(36),

              // Animated "MOVURA" typography
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: "MOVURA"
                    .split("")
                    .asMap()
                    .entries
                    .map((entry) => Text(
                          entry.value,
                          style: TextStyles.font24SemiBoldNeonBlueManrope
                              .copyWith(
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: AppColors.neonBlue.withValues(alpha: 0.7),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        )
                            .animate(delay: (400 + entry.key * 100).ms)
                            .fadeIn(duration: 600.ms)
                            .moveY(begin: 12, end: 0, curve: Curves.easeOutBack)
                            .then()
                            .shimmer(
                              duration: 2.seconds,
                              color: AppColors.darkNeonCyan.withValues(alpha: 0.3),
                            ))
                    .toList(),
              ),

              AppSpacing.verticalSpacing(14),

              // Tagline reveal
              Text(
                'YOUR CINEMATIC UNIVERSE',
                style: TextStyles.font10BoldCoolGray.copyWith(
                  fontSize: 11.sp,
                  letterSpacing: 5.5,
                  color: AppColors.slateGray.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w700,
                ),
              )
                  .animate(delay: 1800.ms)
                  .fadeIn(duration: 800.ms)
                  .blur(begin: const Offset(4, 4), end: Offset.zero),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter that draws a 360-degree orbiting neon cyan laser arc
/// with a glowing particle head moving continuously around the logo emblem.
class _CinematicOrbitPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CinematicOrbitPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;

    // Track circle (faint)
    final trackPaint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, trackPaint);

    // Dynamic Orbiting Laser Arc
    final startAngle = progress * 2 * math.pi;
    const sweepAngle = math.pi / 1.8;

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: 0.4),
          color,
        ],
        stops: const [0.0, 0.6, 1.0],
        transform: GradientRotation(startAngle),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );

    // Glowing head particle at the tip of the arc
    final headAngle = startAngle + sweepAngle;
    final headOffset = Offset(
      center.dx + radius * math.cos(headAngle),
      center.dy + radius * math.sin(headAngle),
    );

    final glowHeadPaint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final headPaint = Paint()
      ..color = Colors.white;

    canvas.drawCircle(headOffset, 4.5, glowHeadPaint);
    canvas.drawCircle(headOffset, 2.5, headPaint);
  }

  @override
  bool shouldRepaint(covariant _CinematicOrbitPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
