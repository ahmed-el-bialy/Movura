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
import 'package:movura/features/auth/ui/widgets/social_button_row.dart';

import '../widgets/hero_app_logo.dart';

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
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.neonBlue.withValues(alpha: 0.4),
                          AppColors.neonBlue.withValues(alpha: 0.3),
                          AppColors.neonBlue.withValues(alpha: 0.4),
                          AppColors.trueBlack,
                          AppColors.trueBlack,
                          AppColors.charcoalBlack,
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpacing(15),
                            HeroAppLogo(),
                            verticalSpacing(10),
                            Text(
                              "Join Movura",
                              style: AppTextStyles.font40BoldPureWhite.copyWith(
                                fontSize: 32.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                            verticalSpacing(6),
                            Text(
                              "Create an account to start your journey",
                              style: AppTextStyles.font12CoolGrayManrope
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.slateGray.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                            ),
                            verticalSpacing(15),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 6.w
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.onyxBlack.withValues(
                                      alpha: 0.25,
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
                                        label: "Full Name",
                                        child: AppTextFormField(
                                          controller: nameController,
                                          hintText: "Ahmed El-Bialy",
                                          prefixIcon: const AuthPrefixIcon(
                                            icon: Icons.person_outline_rounded,
                                          ),
                                          validator: (v) =>
                                              v == null || v.isEmpty
                                              ? "Name is required"
                                              : null,
                                        ),
                                      ),
                                      verticalSpacing(14),
                                      AuthInputField(
                                        label: "Email Address",
                                        child: AppTextFormField(
                                          controller: emailController,
                                          inputType: TextInputType.emailAddress,
                                          hintText: AppConstants.emailExample,
                                          prefixIcon: const AuthPrefixIcon(
                                            icon: Icons.alternate_email_rounded,
                                          ),
                                          validator: Validators.validateEmail,
                                        ),
                                      ),
                                      verticalSpacing(14),
                                      AuthInputField(
                                        label: "Password",
                                        child: AppTextFormField(
                                          controller: passwordController,
                                          isObscureText: isObscure,
                                          hintText: AppConstants
                                              .passwordExample,
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
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: AppTextButton(
                                    buttonText: state is AuthLoading
                                        ? "CREATING ACCOUNT..."
                                        : "SIGN UP",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().signUp(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    buttonWidth: 140.w,
                                    borderRadius: 18.r,
                                    textStyle: AppTextStyles
                                        .font17BoldTrueBlackSora
                                        .copyWith(
                                          fontSize: 16.sp,
                                          letterSpacing: 1.0,
                                        ),
                                  ),
                                );
                              },
                            ),
                            verticalSpacing(20),
                            const AuthDivider(),
                            verticalSpacing(18),
                            SocialButtonsRow(),
                            verticalSpacing(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already a member? ",
                                  style: AppTextStyles.font12CoolGrayManrope,
                                ),
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Text(
                                    "Sign In",
                                    style: AppTextStyles.font13BoldNeonBlueSora
                                        .copyWith(fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpacing(5),
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
