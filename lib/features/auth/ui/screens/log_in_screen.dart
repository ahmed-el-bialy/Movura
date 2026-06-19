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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacing(10),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: AppColors.onyxBlack.withValues(alpha: .9),
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppStrings.mainScreen, null);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          "Skip",
                          style: AppTextStyles.font12CoolGrayManrope,
                        ),
                      ),
                    ),
                  ),
                ),

                verticalSpacing(15),
                SizedBox(
                  height: 70.h,
                  child: Image.asset("assets/images/movura.png"),
                ),

                verticalSpacing(25),
                Text("Welcome Back",
                    style: AppTextStyles.font40BoldPureWhite.copyWith(
                        fontSize: 35.sp)),
                verticalSpacing(4),
                Text(
                  "Sign in to continue your cinematic journey",
                  style: AppTextStyles.font12CoolGrayManrope.copyWith(
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpacing(30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: AppTextStyles.font14SimiBoldPlatinumGraySora
                        .copyWith(fontSize: 12.sp, color: AppColors.slateGray),
                  ),
                ),
                verticalSpacing(8),
                AppTextFormField(
                  hintText: "movura@example.com",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 10.w),
                    child: Icon(
                      Icons.email_outlined,
                      size: 22.sp,
                      color: AppColors.slateGray.withValues(alpha: .9),
                    ),
                  ),
                ),
                verticalSpacing(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Password",
                      style: AppTextStyles.font14SimiBoldPlatinumGraySora
                          .copyWith(
                            fontSize: 12.sp,
                            color: AppColors.slateGray,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot?",
                        style: AppTextStyles.font13MediumNeonBlue.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpacing(8),
                AppTextFormField(
                  hintText: "••••••••",
                  isObscureText: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 10.w),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      size: 22.sp,
                      color: AppColors.slateGray.withValues(alpha: .9),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 14.w),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 22.sp,
                      color: AppColors.slateGray.withValues(alpha: .9),
                    ),
                  ),
                ),

                verticalSpacing(70),

                AppTextButton(
                  buttonText: "Login",
                  onPressed: () {},
                  buttonWidth: 250,
                  buttonHeight: 42,
                  borderRadius: 18,
                  textStyle: AppTextStyles.font17BoldTrueBlackSora.copyWith(
                    fontSize: 16.sp,
                  ),
                ),

                verticalSpacing(25),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.slateGray.withValues(alpha: .7),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: AppTextStyles.font12BoldCoolGray.copyWith(
                          fontSize: 11.sp,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.slateGray.withValues(alpha: .7),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                verticalSpacing(20),

                Row(
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

                verticalSpacing(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                        style: AppTextStyles.font10BoldCoolGray.copyWith(
                          fontSize: 13.sp,
                        ),),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppStrings.logOutScreen, null);
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.font13BoldNeonBlueSora.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                verticalSpacing(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
