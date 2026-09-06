import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _glowAnim = Tween<double>(begin: 0.2, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.pushAndRemoveUntil(routeName: RouteNames.mainScreen);
    } else {
      context.pushAndRemoveUntil(routeName: RouteNames.logInScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _glowAnim,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonBlue.withValues(alpha: 0.25 * _glowAnim.value),
                      AppColors.vibrantPurple.withValues(alpha: 0.15 * _glowAnim.value),
                      AppColors.richEerieBlack,
                    ],
                    radius: 1.2,
                  ),
                ),
              );
            },
          ),
          FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: AppSpacing.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.onyxBlack.withValues(alpha: 0.4),
                      border: Border.all(
                        color: AppColors.neonBlue.withValues(alpha: 0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.35),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.movie_creation_rounded,
                      size: 56.sp,
                      color: AppColors.neonBlue,
                    ),
                  ),
                  AppSpacing.verticalSpacing(24),
                  Text(
                    'MOVURA',
                    style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6.0,
                      shadows: [
                        Shadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.6),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpacing(8),
                  Text(
                    'YOUR CINEMATIC UNIVERSE',
                    style: TextStyles.font10BoldCoolGray.copyWith(
                      fontSize: 11.sp,
                      letterSpacing: 3.5,
                      color: AppColors.slateGray.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
