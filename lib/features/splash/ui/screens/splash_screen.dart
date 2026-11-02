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

import '../widgets/ambient_spheres.dart';
import '../widgets/animated_loading_bar.dart';
import '../widgets/glass_logo_emblem.dart';
import '../widgets/scanline_overlay.dart';

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
      final route = user != null
          ? RouteNames.mainScreen
          : RouteNames.logInScreen;
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
          AmbientSpheres(controller: _sphereController),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Container(
              color: AppColors.richEerieBlack.withValues(alpha: 0.3),
            ),
          ),
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
          const ScanlineOverlay(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const GlassLogoEmblem()
                  .animate()
                  .fade(duration: 700.ms, curve: Curves.easeIn)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.0, 1.0),
                    duration: 900.ms,
                    curve: Curves.easeOutBack,
                  ),
              AppSpacing.verticalSpacing(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: 'MOVURA'
                    .split('')
                    .asMap()
                    .entries
                    .map(
                      (e) =>
                      Text(
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 56.h,
            child: const AnimatedLoadingBar()
                .animate(delay: 600.ms)
                .fadeIn(duration: 400.ms),
          ),
        ],
      ),
    );
  }
}
