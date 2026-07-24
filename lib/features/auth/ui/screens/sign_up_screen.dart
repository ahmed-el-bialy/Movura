import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/helpers/validators.dart';

import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../widgets/build_social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
  bool isConfirmObscure = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.trueBlack,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.neonBlue.withValues(alpha: 0.1),
                AppColors.trueBlack,
                AppColors.trueBlack,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpacing(20),
                      Hero(
                        tag: 'app_logo',
                        child: Image.asset(
                          AppConstants.appLogo,
                          width: 85.w,
                          height: 85.h,
                        ),
                      ),
                      verticalSpacing(20),
                      Text(
                        "Create Account",
                        style: AppTextStyles.font40BoldPureWhite.copyWith(
                          fontSize: 32.sp,
                          letterSpacing: -1,
                        ),
                      ),
                      verticalSpacing(8),
                      Text(
                        "Join the premiere community for cinema lovers",
                        style: AppTextStyles.font12CoolGrayManrope.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.slateGray.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpacing(40),
                      _buildInputField(
                        label: "Email Address",
                        child: AppTextFormField(
                          controller: emailController,
                          hintText: AppConstants.emailExample,
                          prefixIcon: _buildPrefixIcon(Icons.email_outlined),
                          validator: Validators.validateEmail,
                        ),
                      ),
                      verticalSpacing(20),
                      _buildInputField(
                        label: "Password",
                        child: AppTextFormField(
                          controller: passwordController,
                          hintText: AppConstants.signUpPasswordHint,
                          isObscureText: isObscure,
                          prefixIcon: _buildPrefixIcon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onTap: () => setState(() => isObscure = !isObscure),
                            icon: Icon(
                              isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20.sp,
                              color: AppColors.slateGray,
                            ),
                          ),
                          validator: Validators.validatePassword,
                        ),
                      ),
                      verticalSpacing(20),
                      _buildInputField(
                        label: "Confirm Password",
                        child: AppTextFormField(
                          hintText: AppConstants.signUpPasswordHint,
                          isObscureText: isConfirmObscure,
                          prefixIcon: _buildPrefixIcon(Icons.lock_clock_outlined),
                          suffixIcon: IconButton(
                            onTap: () => setState(() => isConfirmObscure = !isConfirmObscure),
                            icon: Icon(
                              isConfirmObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20.sp,
                              color: AppColors.slateGray,
                            ),
                          ),
                          validator: (value) => Validators.validateConfirmPassword(
                            value,
                            password: passwordController.text,
                          ),
                        ),
                      ),
                      verticalSpacing(40),
                      AppTextButton(
                        buttonText: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.goHome();
                          }
                        },
                        buttonWidth: double.infinity,
                        buttonHeight: 56.h,
                        borderRadius: 16.r,
                        textStyle: AppTextStyles.font17BoldTrueBlackSora.copyWith(fontSize: 18.sp),
                      ),
                      verticalSpacing(30),
                      _buildDivider(),
                      verticalSpacing(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildSocialButton(
                            logoPath: "assets/images/google_logo.png",
                            backgroundColor: AppColors.onyxBlack,
                            onTap: () {},
                          ),
                          horizontalSpacing(16),
                          BuildSocialButton(
                            logoPath: "assets/images/facebook_logo.png",
                            backgroundColor: AppColors.onyxBlack,
                            onTap: () {},
                          ),
                          horizontalSpacing(16),
                          BuildSocialButton(
                            logoPath: "assets/images/apple_logo.png",
                            backgroundColor: AppColors.onyxBlack,
                            onTap: () {},
                          ),
                        ],
                      ),
                      verticalSpacing(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: AppTextStyles.font10BoldCoolGray.copyWith(fontSize: 14.sp),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              "Login",
                              style: AppTextStyles.font13BoldNeonBlueSora.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font14SimiBoldPlatinumGraySora.copyWith(fontSize: 13.sp, color: AppColors.slateGray)),
        verticalSpacing(8),
        child,
      ],
    );
  }

  Widget _buildPrefixIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Icon(icon, size: 22.sp, color: AppColors.neonBlue.withValues(alpha: 0.7)),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.slateGray.withValues(alpha: 0.2))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text("OR CONTINUE WITH", style: AppTextStyles.font12BoldCoolGray.copyWith(fontSize: 11.sp, letterSpacing: 1.2)),
        ),
        Expanded(child: Divider(color: AppColors.slateGray.withValues(alpha: 0.2))),
      ],
    );
  }
}
  ),
    );
  }
}
