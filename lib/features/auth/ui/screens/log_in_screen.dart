import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/helpers/validators.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_icon_button.dart';
import 'package:movura/core/widgets/app_text_button.dart';
import 'package:movura/core/widgets/app_text_form_field.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';
import 'package:movura/features/auth/ui/widgets/auth_divider.dart';
import 'package:movura/features/auth/ui/widgets/auth_input_field.dart';
import 'package:movura/features/auth/ui/widgets/auth_prefix_icon.dart';

import '../../../../core/routing/route_names.dart';
import '../widgets/build_social_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool isObscure = true;

  @override
  void dispose() {
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
                          verticalSpacing(10),
                          Align(
                            alignment: Alignment.topRight,
                            child: Material(
                              color: AppColors.onyxBlack.withValues(alpha: .6),
                              borderRadius: BorderRadius.circular(12.r),
                              child: InkWell(
                                onTap: () => context.goHome(),
                                borderRadius: BorderRadius.circular(12.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  child: Text(
                                    "Skip",
                                    style: AppTextStyles.font12CoolGrayManrope
                                        .copyWith(color: AppColors.neonBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpacing(20),
                          Hero(
                            tag: 'app_logo',
                            child: Image.asset(
                              AppConstants.appLogo,
                              width: 100.w,
                              height: 100.h,
                            ),
                          ),
                          verticalSpacing(20),
                          Text(
                            "Welcome Back",
                            style: AppTextStyles.font40BoldPureWhite.copyWith(
                              fontSize: 32.sp,
                              letterSpacing: -1,
                            ),
                          ),
                          verticalSpacing(8),
                          Text(
                            "Sign in to continue your cinematic journey",
                            style: AppTextStyles.font12CoolGrayManrope.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.slateGray.withValues(alpha: 0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpacing(40),
                          AuthInputField(
                            label: "Email Address",
                            child: AppTextFormField(
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
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
                            action: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot?",
                                style: AppTextStyles.font13MediumNeonBlue,
                              ),
                            ),
                            child: AppTextFormField(
                              controller: passwordController,
                              inputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              hintText: AppConstants.logInPasswordHint,
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
                          verticalSpacing(40),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return AppTextButton(
                                buttonText:
                                    state is AuthLoading
                                        ? "Logging in..."
                                        : "Login",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      emailController.text.trim(),
                                      passwordController.text,
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
                                "Don't have an account? ",
                                style: AppTextStyles.font10BoldCoolGray.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () => context.pushNamed(
                                      RouteNames.signUpScreen,
                                      null,
                                    ),
                                child: Text(
                                  "Sign Up",
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
