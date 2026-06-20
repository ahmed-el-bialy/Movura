import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/utils/constants/app_constants.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';
import 'package:movura/core/utils/helpers/spacing.dart';
import 'package:movura/core/widgets/app_text_button.dart';
import 'package:movura/core/widgets/app_text_form_field.dart';
import 'package:movura/core/widgets/section_title.dart';

import '../widgets/build_social_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final email = TextEditingController();

  bool isObscure = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.trueBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Form(
                key: formKey,
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
                            context.pushNamed(AppConstants.mainScreen, null);
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

                    Image.asset(
                      AppConstants.appLogo,
                      width: 85.w,
                      height: 85.h,
                    ),

                    Text(
                      "Welcome Back",
                      style: AppTextStyles.font40BoldPureWhite.copyWith(
                        fontSize: 35.sp,
                      ),
                    ),
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
                            .copyWith(
                          fontSize: 12.sp,
                          color: AppColors.slateGray,
                        ),
                      ),
                    ),
                    verticalSpacing(8),
                    AppTextFormField(
                      controller: email,
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: "movura@example.com",
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 10.w),
                        child: Icon(
                          Icons.email_outlined,
                          size: 22.sp,
                          color: AppColors.slateGray.withValues(alpha: .9),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return "Email is required";
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    verticalSpacing(20),

                    SectionTitle(
                      sectionName: "Password",
                      actionName: "Forgot?",
                      onTap: () {},
                      titleStyle: AppTextStyles.font14SimiBoldPlatinumGraySora
                          .copyWith(
                        fontSize: 12.sp,
                        color: AppColors.slateGray,
                      ),
                      actionStyle: AppTextStyles.font13MediumNeonBlue,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                    ),

                    verticalSpacing(8),

                    AppTextFormField(
                      hintText: isObscure == true ? "••••••••" : "Password",
                      controller: password,
                      inputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      isObscureText: isObscure,
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
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 22.sp,
                            color: AppColors.slateGray.withValues(alpha: .9),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        final passwordRegex = RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).+$');

                        if (!passwordRegex.hasMatch(value)) {
                          return "Password must contain uppercase, lowercase, number, and special character (e.g. #)";
                        }

                        return null;
                      },),

                    verticalSpacing(65),

                    AppTextButton(
                      buttonText: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.pushNamed(AppConstants.mainScreen, null);
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.w),
                                  const Text(
                                    "Please fill all fields correctly",
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          );
                        }
                      },
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

                    verticalSpacing(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppTextStyles.font10BoldCoolGray.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(AppConstants.signUpScreen, null);
                          },
                          child: Text(
                            "Sign Up",
                            style: AppTextStyles.font13BoldNeonBlueSora
                                .copyWith(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
