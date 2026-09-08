import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

/// Next-Gen Cinematic Splash Screen for Movura
/// Features: Continuous fluid laser orbit canvas around logo, pure neon blue & eerie black palette (zero purple),
/// staggered text reveal, and seamless authentication routing.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _orbitController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final List<Animation<double>> _letterAnims;
  late final Animation<double> _subTitleFade;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Continuous 360-degree laser orbit & pulsing wave controller
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )
      ..repeat();

    // 1. Logo Scale & Fade with smooth elastic curve
    _logoScale = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // 2. Staggered letter animations for "MOVURA"
    const text = "MOVURA";
    _letterAnims = List.generate(text.length, (index) {
      final start = 0.35 + (index * 0.07);
      final end = (start + 0.25).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    // 3. Tagline fade in
    _subTitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _mainController.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2900));
    if (!mounted) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      final targetRoute = user != null
          ? RouteNames.mainScreen
          : RouteNames.logInScreen;

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
    _mainController.dispose();
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
          // Background ambient pulse (pure cyan & deep black — zero purple)
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              final pulse = 0.16 +
                  (0.07 * math.sin(_orbitController.value * 2 * math.pi));
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonBlue.withValues(alpha: pulse),
                      AppColors.darkNeonCyan.withValues(alpha: pulse * 0.4),
                      AppColors.richEerieBlack,
                    ],
                    center: Alignment.center,
                    radius: 1.0,
                  ),
                ),
              );
            },
          ),

          // Main splash logo with dynamic orbiting laser canvas
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _logoSlide,
                child: FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: SizedBox(
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
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.play_circle_fill_rounded,
                                      size: 80.sp,
                                      color: AppColors.neonBlue,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              AppSpacing.verticalSpacing(36),

              // Animated "MOVURA" typography
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate("MOVURA".length, (index) {
                  return AnimatedBuilder(
                    animation: _letterAnims[index],
                    builder: (context, child) {
                      final val = _letterAnims[index].value.clamp(0.0, 1.0);
                      return Transform.translate(
                        offset: Offset(0, 12 * (1 - val)),
                        child: Opacity(
                          opacity: val,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              "MOVURA"[index],
                              style: TextStyles.font24SemiBoldNeonBlueManrope
                                  .copyWith(
                                fontSize: 38.sp,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: AppColors.neonBlue.withValues(
                                      alpha: 0.65 * val,
                                    ),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              AppSpacing.verticalSpacing(14),

              // Tagline reveal
              FadeTransition(
                opacity: _subTitleFade,
                child: Text(
                  'YOUR CINEMATIC UNIVERSE',
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    fontSize: 11.sp,
                    letterSpacing: 5.5,
                    color: AppColors.slateGray.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
