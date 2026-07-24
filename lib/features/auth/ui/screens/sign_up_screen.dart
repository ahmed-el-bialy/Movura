import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/helpers/validators.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';
import 'package:movura/features/auth/ui/widgets/auth_divider.dart';
import 'package:movura/features/auth/ui/widgets/auth_input_field.dart';
import 'package:movura/features/auth/ui/widgets/auth_prefix_icon.dart';

import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';
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
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      context.goHome();
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: _listenToAuthState,
        child: GestureDetector(
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
                          verticalSpacing(30),
                          AuthInputField(
                            label: "Full Name",
                            child: AppTextFormField(
                              controller: nameController,
                              hintText: "John Doe",
                              prefixIcon: const AuthPrefixIcon(
                                icon: Icons.person_outline_rounded,
                              ),
                              validator:
                                  (value) =>
                              value == null || value.isEmpty
                                  ? "Name is required"
                                  : null,
                            ),
                          ),
                          verticalSpacing(20),
                          AuthInputField(
                            label: "Email Address",
                            child: AppTextFormField(
                              controller: emailController,
                              hintText: AppConstants.emailExample,
                              prefixIcon: const AuthPrefixIcon(
                                icon: Icons.email_outlined,
                              ),
                              validator: Validators.validateEmail,
                            ),
                          ),
                          verticalSpacing(20),
                          AuthInputField(
                            label: "Password",
                            child: AppTextFormField(
                              controller: passwordController,
                              hintText: AppConstants.signUpPasswordHint,
                              isObscureText: isObscure,
                              prefixIcon: const AuthPrefixIcon(
                                icon: Icons.lock_outline_rounded,
                              ),
                              suffixIcon: AppIconButton(
                                onPressed:
                                    () => setState(() => isObscure = !isObscure),
                                icon: isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                iconColor: AppColors.slateGray,
                                size: 20,
                              ),
                              validator: Validators.validatePassword,
                            ),
                          ),
                          verticalSpacing(20),
                          AuthInputField(
                            label: "Confirm Password",
                            child: AppTextFormField(
                              hintText: AppConstants.signUpPasswordHint,
                              isObscureText: isConfirmObscure,
                              prefixIcon: const AuthPrefixIcon(
                                icon: Icons.lock_clock_outlined,
                              ),
                              suffixIcon: AppIconButton(
                                onPressed:
                                    () =>
                                    setState(
                                          () =>
                                      isConfirmObscure = !isConfirmObscure,
                                    ),
                                icon: isConfirmObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                iconColor: AppColors.slateGray,
                                size: 20,
                              ),
                              validator:
                                  (value) =>
                                  Validators.validateConfirmPassword(
                                    value,
                                    password: passwordController.text,
                                  ),
                            ),
                          ),
                          verticalSpacing(40),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return AppTextButton(
                                buttonText:
                                state is AuthLoading
                                    ? "Creating Account..."
                                    : "Sign Up",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().signUp(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 56.h,
                                borderRadius: 16.r,
                                textStyle: AppTextStyles.font17BoldTrueBlackSora
                                    .copyWith(fontSize: 18.sp),
                              );
                            },
                          ),
                          verticalSpacing(30),
                          const AuthDivider(),
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
                                style: AppTextStyles.font10BoldCoolGray
                                    .copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Text(
                                  "Login",
                                  style: AppTextStyles.font13BoldNeonBlueSora
                                      .copyWith(
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
        ),
      ),
    );
  }
}
