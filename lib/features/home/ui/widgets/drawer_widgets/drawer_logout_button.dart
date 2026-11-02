import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DrawerLogoutButton extends StatelessWidget {
  const DrawerLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return Padding(
      padding: AppSpacing.all(20),
      child: InkWell(
        onTap: () async {
          context.pop();
          if (isLoggedIn) {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              context.pushAndRemoveUntil(routeName: RouteNames.logInScreen);
            }
          } else {
            context.pushNamed(RouteNames.logInScreen);
          }
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: AppSpacing.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            color: (isLoggedIn ? AppColors.softRed : AppColors.neonBlue)
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: (isLoggedIn ? AppColors.softRed : AppColors.neonBlue)
                  .withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isLoggedIn ? Icons.logout_rounded : Icons.login_rounded,
                color: isLoggedIn ? AppColors.softRed : AppColors.neonBlue,
                size: 20.sp,
              ),
              AppSpacing.horizontalSpacing(AppSpacing.m),
              Text(
                isLoggedIn ? 'Sign Out' : 'Sign In',
                style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                  color: isLoggedIn ? AppColors.softRed : AppColors.neonBlue,
                  fontWeight: Weights.black,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
