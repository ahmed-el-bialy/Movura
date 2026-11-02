import 'dart:math' as math;
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

/// Cinematic Splash Screen — Movura
///
/// Design principles:
///  • Matches the Auth screen aesthetic: deep eerie black + floating neon glows
///  • Renders a crisp glass "M" emblem — no white-background PNG artifacts
///  • Staggered letter-by-letter MOVURA reveal (flutter_animate)
///  • Subtle scanline overlay for an authentic cinema-screen feel
///  • Soft animated loading bar at the bottom
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sphereController;

  @override
  void initState() {
    super.initState();
    _sphereController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 3400));
    if (!mounted) return;
    try {
      final user = FirebaseAuth.instance.currentUser;
      final route =
          user != null ? RouteNames.mainScreen : RouteNames.logInScreen;
      if (mounted) context.pushAndRemoveUntil(routeName: route);
    } catch (_) {
      if (mounted) {
        context.pushAndRemoveUntil(routeName: RouteNames.logInScreen);
      }
    }
  }

  @override
  void dispose() {
    _sphereController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Layer 1: Ambient neon glow spheres (matches AuthBackground) ──
          _AmbientSpheres(controller: _sphereController),

          // ── Layer 2: Backdrop blur — exact same as AuthBackground ────────
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Container(
              color: AppColors.richEerieBlack.withValues(alpha: 0.3),
            ),
          ),

          // ── Layer 3: Radial vignette ─────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  AppColors.trueBlack.withValues(alpha: 0.65),
                ],
                radius: 1.1,
              ),
            ),
          ),

          // ── Layer 4: Scanline overlay (subtle cinema-screen texture) ─────
          const _ScanlineOverlay(),

          // ── Layer 5: Central logo + typography ──────────────────────────
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glass "M" emblem — clean, no white PNG background
              _GlassLogoEmblem()
                  .animate()
                  .fade(duration: 700.ms, curve: Curves.easeIn)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.0, 1.0),
                    duration: 900.ms,
                    curve: Curves.easeOutBack,
                  ),

              AppSpacing.verticalSpacing(40),

              // "MOVURA" letter-by-letter reveal
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: 'MOVURA'
                    .split('')
                    .asMap()
                    .entries
                    .map(
                      (e) => Text(
                        e.value,
                        style: TextStyles.font24SemiBoldNeonBlueManrope
                            .copyWith(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                          shadows: [
                            Shadow(
                              color: AppColors.neonBlue.withValues(alpha: 0.75),
                              blurRadius: 22,
                            ),
                          ],
                        ),
                      )
                          .animate(delay: (350 + e.key * 90).ms)
                          .fadeIn(duration: 500.ms)
                          .moveY(
                            begin: 14,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic,
                          ),
                    )
                    .toList(),
              ),

              AppSpacing.verticalSpacing(12),

              // Tagline
              Text(
                'YOUR CINEMATIC UNIVERSE',
                style: TextStyles.font10BoldCoolGray.copyWith(
                  fontSize: 10.sp,
                  letterSpacing: 5.0,
                  color: AppColors.slateGray.withValues(alpha: 0.75),
                ),
              )
                  .animate(delay: 1800.ms)
                  .fadeIn(duration: 700.ms)
                  .blur(begin: const Offset(5, 0), end: Offset.zero),
            ],
          ),

          // ── Layer 6: Loading bar pinned to bottom ────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 56.h,
            child: _AnimatedLoadingBar()
                .animate(delay: 600.ms)
                .fadeIn(duration: 400.ms),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ambient glowing spheres — mirrors AuthBackground._buildSpheres()
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientSpheres extends StatelessWidget {
  const _AmbientSpheres({required this.controller});

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
      2 => Alignment(0.3 + 0.35 * math.sin(t * 0.8 + 1), -0.2 + 0.25 * math.cos(t * 1.2)),
      _ => Alignment(-0.4 + 0.3 * math.cos(t * 0.9 + 2), 0.65 + 0.2 * math.sin(t * 1.3)),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scanline overlay — subtle horizontal lines for cinema feel
// ─────────────────────────────────────────────────────────────────────────────

class _ScanlineOverlay extends StatelessWidget {
  const _ScanlineOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ScanlinePainter());
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Glass "M" emblem — drawn via CustomPaint, no white background PNG
// ─────────────────────────────────────────────────────────────────────────────

class _GlassLogoEmblem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.r,
      height: 130.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 130.r,
            height: 130.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonBlue.withValues(alpha: 0.35),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
              gradient: RadialGradient(
                colors: [
                  AppColors.neonBlue.withValues(alpha: 0.12),
                  AppColors.darkNeonCyan.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Glass panel
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 110.r,
                height: 110.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.richEerieBlack.withValues(alpha: 0.55),
                  border: Border.all(
                    color: AppColors.neonBlue.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: Size(58.r, 58.r),
                    painter: _MLetterPainter(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws the Movura "M" lettermark in neon blue — matches the app icon shape.
class _MLetterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const strokeW = 5.5;
    const r = 10.0; // corner radius for rounded caps

    final paint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1.0);

    final w = size.width;
    final h = size.height;

    // Left vertical leg (rounded bottom)
    final leftLeg = Path()
      ..moveTo(w * 0.12, h * 0.05)
      ..lineTo(w * 0.12, h * 0.82)
      ..arcToPoint(
        Offset(w * 0.12 + r, h * 0.82 + r),
        radius: const Radius.circular(r),
        clockwise: true,
      );

    // Left diagonal down to V valley
    final leftDiag = Path()
      ..moveTo(w * 0.12, h * 0.05)
      ..lineTo(w * 0.50, h * 0.52);

    // Right diagonal up from V valley
    final rightDiag = Path()
      ..moveTo(w * 0.50, h * 0.52)
      ..lineTo(w * 0.88, h * 0.05);

    // Right vertical leg (rounded bottom)
    final rightLeg = Path()
      ..moveTo(w * 0.88, h * 0.05)
      ..lineTo(w * 0.88, h * 0.82)
      ..arcToPoint(
        Offset(w * 0.88 - r, h * 0.82 + r),
        radius: const Radius.circular(r),
        clockwise: false,
      );

    // Glow layer
    final glowPaint = Paint()
      ..color = AppColors.neonBlue.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW + 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    for (final path in [leftLeg, leftDiag, rightDiag, rightLeg]) {
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated loading bar
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedLoadingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barWidth = 140.w;

    return Center(
      child: SizedBox(
        width: barWidth,
        height: 2.h,
        child: Stack(
          children: [
            // Track
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkSlateGray.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Fill
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [AppColors.darkNeonCyan, AppColors.neonBlue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonBlue.withValues(alpha: 0.6),
                    blurRadius: 8,
                  ),
                ],
              ),
            )
                .animate()
                .custom(
                  duration: 2800.ms,
                  curve: Curves.easeInOut,
                  builder: (_, value, child) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value.clamp(0.0, 1.0),
                    child: child,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
