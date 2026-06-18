import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/utils/constants/strings.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';
import 'package:movura/core/utils/helpers/spacing.dart';
import 'package:movura/core/widgets/app_text_button.dart';
import 'package:movura/core/widgets/app_text_form_field.dart';

import '../widgets/build_social_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trueBlack,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Align(
                    alignment: AlignmentGeometry.topRight,
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppStrings.mainScreen, null);
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onyxBlack.withValues(alpha: .9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Skip",
                          style: AppTextStyles.font12CoolGrayManrope,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                  child: Image.asset("assets/images/movura.png"),
                ),

                verticalSpacing(20),
                Text("Welcome Back", style: AppTextStyles.font40BoldPureWhite),
                Text(
                  "Sign in to continue your cinematic journey",
                  style: AppTextStyles.font12CoolGrayManrope.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                verticalSpacing(20),

                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    "Email Address",
                    style: AppTextStyles.font14SimiBoldPlatinumGraySora
                        .copyWith(fontSize: 12.sp, color: AppColors.slateGray),
                  ),
                ),
                verticalSpacing(8),
                AppTextFormField(
                  hintText: "movura@example.com",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 23.sp,
                    color: AppColors.slateGray.withValues(alpha: .9),
                  ),
                ),
                verticalSpacing(35),

                Row(
                  children: [
                    Text(
                      "Password",
                      style: AppTextStyles.font14SimiBoldPlatinumGraySora
                          .copyWith(
                            fontSize: 12.sp,
                            color: AppColors.slateGray,
                          ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      "Forgot?",
                      style: AppTextStyles.font13MediumNeonBlue.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                verticalSpacing(8),
                AppTextFormField(
                  hintText: "••••••••",
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 23.sp,
                    color: AppColors.slateGray.withValues(alpha: .9),
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 23.sp,
                    color: AppColors.slateGray.withValues(alpha: .9),
                  ),
                ),

                verticalSpacing(20),

                AppTextButton(
                  buttonText: "Login",
                  onPressed: () {},
                  buttonWidth: 280,
                  borderRadius: 30,
                ),

                verticalSpacing(30),

                Text(
                  "OR CONTINUE WITH",
                  style: AppTextStyles.font12BoldCoolGray,
                ),

                verticalSpacing(15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildSocialButton(
                      assetPath: "assets/images/google_logo.png",
                      backgroundColor: AppColors.onyxBlack,
                      onTap: () {},
                    ),
                    BuildSocialButton(
                      assetPath: "assets/images/facebook_logo.png",
                      backgroundColor: AppColors.onyxBlack,
                      onTap: () {},
                    ),
                    BuildSocialButton(
                      assetPath: "assets/images/apple_logo.png",
                      backgroundColor: AppColors.onyxBlack,
                      onTap: () {},
                    ),
                  ],
                ),

                verticalSpacing(15),
                Spacer(flex: 1),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.font10BoldCoolGray,
                    children: [
                      TextSpan(text: "Already have an account yet? "),
                      TextSpan(
                        text: "Sign Up ",
                        style: AppTextStyles.font12CoolGrayManrope,
                      ),
                    ],
                  ),
                ),
                verticalSpacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
