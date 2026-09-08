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
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _pulseController;

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
      duration: const Duration(milliseconds: 2400),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // 1. Logo Scale & Fade
    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
      ),
    );

    // Subtle upward float for cinematic effect
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
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
      final start = 0.3 + (index * 0.07);
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
        curve: const Interval(0.65, 0.95, curve: Curves.easeIn),
      ),
    );

    _mainController.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2700));
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
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Minimal ambient background glow (pulsing gently)
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final pulse = 0.15 + (0.08 * _pulseController.value);
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonBlue.withValues(alpha: pulse),
                      AppColors.vibrantPurple.withValues(alpha: pulse * 0.5),
                      AppColors.richEerieBlack,
                    ],
                    center: Alignment.center,
                    radius: 0.9,
                  ),
                ),
              );
            },
          ),

          // Main cinematic splash content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Clean, frameless floating logo with dynamic glow
              SlideTransition(
                position: _logoSlide,
                child: FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonBlue.withValues(alpha: 0.35),
                            blurRadius: 50,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/app_icon_1024.png',
                        width: 110.w,
                        height: 110.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.play_circle_fill_rounded,
                          size: 90.sp,
                          color: AppColors.neonBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              AppSpacing.verticalSpacing(32),

              // Minimalist letter-by-letter "MOVURA" typography
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
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.neonBlue.withValues(
                                          alpha: 0.6 * val,
                                        ),
                                        blurRadius: 18,
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

              // Subtitle Tagline
              FadeTransition(
                opacity: _subTitleFade,
                child: Text(
                  'YOUR CINEMATIC UNIVERSE',
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    fontSize: 11.sp,
                    letterSpacing: 5.0,
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
