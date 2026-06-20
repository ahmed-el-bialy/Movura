import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/utils/constants/app_constants.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/extensions/routing_extension.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../widgets/build_social_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.trueBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpacing(8),

                  Image.asset(AppConstants.appLogo, width: 85.w, height: 85.h,),

                  Text(
                    "Create Account",
                    style: AppTextStyles.font40BoldPureWhite.copyWith(
                      fontSize: 35.sp,
                    ),
                  ),
                  verticalSpacing(4),
                  Text(
                    "Join the premiere community for cinema lovers, fans, and enthusiasts.",
                    style: AppTextStyles.font12CoolGrayManrope.copyWith(
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(15),

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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: AppTextStyles.font14SimiBoldPlatinumGraySora
                          .copyWith(fontSize: 12.sp, color: AppColors.slateGray),
                    ),
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

                  verticalSpacing(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: AppTextStyles.font14SimiBoldPlatinumGraySora
                          .copyWith(fontSize: 12.sp, color: AppColors.slateGray),
                    ),
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

                  verticalSpacing(30),

                  AppTextButton(
                    buttonText: "Sign Up",
                    onPressed: () {

                    },
                    buttonWidth: 250,
                    buttonHeight: 42,
                    borderRadius: 18,
                    textStyle: AppTextStyles.font17BoldTrueBlackSora.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),

                  verticalSpacing(20),

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

                  verticalSpacing(15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildSocialButton(
                        logoPath: "assets/images/google_logo.png",
                        backgroundColor: AppColors.onyxBlack,
                        onTap: () {},
                      ),
                      BuildSocialButton(
                        logoPath: "assets/images/facebook_logo.png",
                        backgroundColor: AppColors.onyxBlack,
                        onTap: () {},
                      ),
                      BuildSocialButton(
                        logoPath: "assets/images/apple_logo.png",
                        backgroundColor: AppColors.onyxBlack,
                        onTap: () {},
                      ),
                    ],
                  ),

                  verticalSpacing(15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyles.font10BoldCoolGray.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          "Login",
                          style: AppTextStyles.font13BoldNeonBlueSora.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
