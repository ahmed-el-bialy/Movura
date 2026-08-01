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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
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
                          AppColors.neonBlue.withValues(alpha: 0.3),
                          AppColors.neonBlue.withValues(alpha: 0.2),
                          AppColors.trueBlack,
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpacing(20),
                            HeroAppLogo(),
                            verticalSpacing(5),
                            Text(
                              "Create Account",
                              style: TextStyles.font40BoldPureWhite.copyWith(
                                fontSize: 32.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              "Join the premiere community for cinema lovers",
                              style: TextStyles.font12CoolGrayManrope.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.slateGray.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            verticalSpacing(25),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.trueBlack.withValues(alpha: 0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.r),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 20.h,
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
                                        label: "Full Name",
                                        child: AppTextFormField(
                                          controller: nameController,
                                          hintText: "John Doe",
                                          prefixIcon: const AuthPrefixIcon(
                                            icon: Icons.person_outline_rounded,
                                          ),
                                          textInputAction: TextInputAction.next,
                                          validator: (v) => v == null || v.isEmpty ? "Name is required" : null,
                                        ),
                                      ),
                                      verticalSpacing(16),
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
                                      verticalSpacing(16),
                                      AuthInputField(
                                        label: "Password",
                                        child: AppTextFormField(
                                          controller: passwordController,
                                          isObscureText: isObscure,
                                          hintText: AppConstants.passwordExample,
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
                            ),
                            verticalSpacing(30),
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
                                    buttonWidth: double.infinity,
                                    buttonHeight: 52,
                                    borderRadius: 30.r,
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
                            verticalSpacing(30),
                            const AuthDivider(),
                            verticalSpacing(20),
                            SocialButtonsRow(),
                            verticalSpacing(25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already a member? ",
                                  style: TextStyles.font12CoolGrayManrope,
                                ),
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyles.font13BoldNeonBlueSora
                                        .copyWith(fontWeight: FontWeight.w800),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
