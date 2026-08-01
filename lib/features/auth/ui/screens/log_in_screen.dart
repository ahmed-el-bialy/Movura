import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/helpers/validators.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_text_button.dart';
import 'package:movura/core/widgets/app_text_form_field.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';
import 'package:movura/features/auth/ui/widgets/auth_divider.dart';
import 'package:movura/features/auth/ui/widgets/auth_input_field.dart';
import 'package:movura/features/auth/ui/widgets/auth_prefix_icon.dart';
import 'package:movura/features/auth/ui/widgets/hero_app_logo.dart';
import 'package:movura/features/auth/ui/widgets/social_button_row.dart';

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
    if (state is AuthLoaded) {
      context.pushAndRemoveUntil(routeName: RouteNames.mainScreen);
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.softRed,
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
            body: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.neonBlue.withValues(alpha: 0.4),
                          AppColors.neonBlue.withValues(alpha: 0.3),
                          AppColors.neonBlue.withValues(alpha: 0.4),
                          AppColors.trueBlack,
                          AppColors.trueBlack,
                          AppColors.trueBlack,
                          AppColors.charcoalBlack,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -50.h,
                  right: -50.w,
                  child: Container(
                    width: 200.r,
                    height: 200.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neonBlue.withValues(alpha: 0.1),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                      child: Container(color: AppColors.transparent),
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpacing(10),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () => context.pushAndRemoveUntil(
                                  routeName: RouteNames.mainScreen,
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.onyxBlack
                                      .withValues(alpha: 0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                child: Text(
                                  "Skip",
                                  style: TextStyles.font13MediumNeonBlue
                                      .copyWith(fontSize: 12.sp),
                                ),
                              ),
                            ),
                            HeroAppLogo(),
                            verticalSpacing(5),
                            Text(
                              "Welcome Back",
                              style: TextStyles.font40BoldPureWhite.copyWith(
                                fontSize: 34.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              "Sign in to continue your cinematic journey",
                              style: TextStyles.font12CoolGrayManrope.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.slateGray.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                            verticalSpacing(18),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.onyxBlack.withValues(
                                      alpha: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.all(
                                      color: AppColors.pureWhite.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      AuthInputField(
                                        label: "Email Address",
                                        child: AppTextFormField(
                                          controller: emailController,
                                          inputType: TextInputType.emailAddress,
                                          hintText: AppConstants.emailExample,
                                          prefixIcon: const AuthPrefixIcon(
                                            icon: Icons.alternate_email_rounded,
                                          ),
                                          textInputAction: TextInputAction.next,
                                          validator: Validators.validateEmail,
                                        ),
                                      ),
                                      verticalSpacing(20),
                                      AuthInputField(
                                        label: "Password",
                                        action: Text(
                                          "Forgot?",
                                          style: TextStyles.font13MediumNeonBlue
                                              .copyWith(fontSize: 11.sp),
                                        ),
                                        child: AppTextFormField(
                                          controller: passwordController,
                                          isObscureText: isObscure,
                                          hintText:
                                              AppConstants.passwordExample,
                                          prefixIcon: const AuthPrefixIcon(
                                            icon: Icons.lock_outline_rounded,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () => setState(
                                              () => isObscure = !isObscure,
                                            ),
                                            icon: Icon(
                                              isObscure
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AppColors.coolGray,
                                              size: 18.sp,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          validator:
                                              Validators.validatePassword,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            verticalSpacing(25),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.neonBlue.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: AppTextButton(
                                    buttonText: state is AuthLoading
                                        ? "AUTHENTICATING..."
                                        : "LOGIN",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                          emailController.text.trim(),
                                          passwordController.text,
                                        );
                                      }
                                    },
                                    buttonWidth: 240.w,
                                    borderRadius: 16.r,
                                    textStyle: TextStyles
                                        .font17BoldTrueBlackSora
                                        .copyWith(
                                          fontSize: 16.sp,
                                          letterSpacing: 1.2,
                                        ),
                                  ),
                                );
                              },
                            ),
                            verticalSpacing(25),
                            const AuthDivider(),
                            verticalSpacing(20),
                            SocialButtonsRow(),
                            verticalSpacing(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "New here? ",
                                  style: TextStyles.font12CoolGrayManrope,
                                ),
                                GestureDetector(
                                  onTap: () => context.pushNamed(
                                    RouteNames.signUpScreen,
                                  ),
                                  child: Text(
                                    "Create Account",
                                    style: TextStyles.font13BoldNeonBlueSora
                                        .copyWith(fontWeight: FontWeight.w800),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
