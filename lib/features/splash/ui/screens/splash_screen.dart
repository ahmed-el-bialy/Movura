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
  late final AnimationController _bgController;

  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final List<Animation<double>> _letterAnims;
  late final Animation<double> _subTitleFadeAnim;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Staggered letter animations for "MOVURA"
    // Using Curves.easeOutCubic so value stays strictly within [0.0, 1.0] for Opacity
    const text = "MOVURA";
    _letterAnims = List.generate(text.length, (index) {
      final start = 0.3 + (index * 0.08);
      final end = (start + 0.3).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    _subTitleFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _mainController.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2600));
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
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient light blobs in background
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _bgController,
              builder: (context, child) {
                final offset = index == 0
                    ? Offset(
                        -0.4 + (0.2 * _bgController.value),
                        -0.3 + (0.1 * _bgController.value),
                      )
                    : index == 1
                    ? Offset(
                        0.3 - (0.2 * _bgController.value),
                        0.4 - (0.1 * _bgController.value),
                      )
                    : Offset(
                        -0.2 + (0.1 * _bgController.value),
                        0.5 - (0.2 * _bgController.value),
                      );

                return Align(
                  alignment: Alignment(offset.dx, offset.dy),
                  child: Container(
                    width: (250 + (index * 50)).r,
                    height: (250 + (index * 50)).r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          (index == 0
                                  ? AppColors.neonBlue
                                  : index == 1
                                  ? AppColors.vibrantPurple
                                  : AppColors.electricBlueAccent)
                              .withValues(alpha: 0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Container(
                    padding: AppSpacing.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.onyxBlack.withValues(alpha: 0.4),
                      border: Border.all(
                        color: AppColors.neonBlue.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.25),
                          blurRadius: 40,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/app_icon_1024.png',
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.movie_creation_rounded,
                        size: 60.sp,
                        color: AppColors.neonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalSpacing(32),

              // Animated "MOVURA" text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate("MOVURA".length, (index) {
                  return AnimatedBuilder(
                    animation: _letterAnims[index],
                    builder: (context, child) {
                      final val = _letterAnims[index].value.clamp(0.0, 1.0);
                      return Transform.translate(
                        offset: Offset(0, 10 * (1 - val)),
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
                                    letterSpacing: 0,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.neonBlue.withValues(
                                          alpha: 0.5 * val,
                                        ),
                                        blurRadius: 15,
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

              AppSpacing.verticalSpacing(12),

              FadeTransition(
                opacity: _subTitleFadeAnim,
                child: Text(
                  'YOUR CINEMATIC UNIVERSE',
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    fontSize: 12.sp,
                    letterSpacing: 4.5,
                    color: AppColors.slateGray.withValues(alpha: 0.7),
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
