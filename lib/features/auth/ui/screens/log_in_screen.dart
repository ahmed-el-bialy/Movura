import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/validators.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/buttons/app_text_button.dart';
import 'package:movura/core/widgets/fields/app_text_form_field.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/auth/auth_state.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_prefix_icon.dart';
import '../widgets/social_button_row.dart';

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
                const AuthBackground(),
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: AppSpacing.horizontal(10),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSpacing.verticalSpacing(10),
                            const _SkipButton(),
                            const AuthHeader(
                              title: "Welcome Back",
                              subtitle:
                                  "Sign in to continue your cinematic journey",
                            ),
                            AppSpacing.verticalSpacing(18),
                            AuthFormContainer(
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
                                  AppSpacing.verticalSpacing(20),
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
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: AppColors.coolGray,
                                          size: 18.sp,
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      validator: Validators.validatePassword,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.verticalSpacing(25),
                            _LoginButton(
                              formKey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                            ),
                            AppSpacing.verticalSpacing(30),
                            const AuthDivider(),
                            AppSpacing.verticalSpacing(AppSpacing.l),
                            SocialButtonsRow(),
                            AppSpacing.verticalSpacing(AppSpacing.l),
                            const _SignUpToggle(),
                            AppSpacing.verticalSpacing(10),
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

class _SkipButton extends StatelessWidget {
  const _SkipButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () =>
            context.pushAndRemoveUntil(routeName: RouteNames.mainScreen),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Text(
          "Skip",
          style: TextStyles.font13MediumNeonBlue.copyWith(fontSize: 12.sp),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AppTextButton(
            buttonText: state is AuthLoading ? "AUTHENTICATING..." : "LOGIN",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthCubit>().login(
                  emailController.text.trim(),
                  passwordController.text,
                );
              }
            },
            buttonWidth: 220.w,
            buttonHeight: 36.h,
            borderRadius: 16.r,
            textStyle: TextStyles.font17BoldTrueBlackSora.copyWith(
              fontSize: 16.sp,
              letterSpacing: 1.2,
            ),
          ),
        );
      },
    );
  }
}

class _SignUpToggle extends StatelessWidget {
  const _SignUpToggle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New here? ", style: TextStyles.font12RegularCoolGrayManrope),
        GestureDetector(
          onTap: () => context.pushNamed(RouteNames.signUpScreen),
          child: Text(
            "Create Account",
            style: TextStyles.font13BoldNeonBlueSora.copyWith(
              fontSize: 12.sp,
              fontWeight: Weights.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
