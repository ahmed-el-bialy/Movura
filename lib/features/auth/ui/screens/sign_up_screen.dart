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
                const AuthBackground(isSignUp: true),
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
                            AppSpacing.verticalSpacing(20),
                            const AuthHeader(
                              title: "Create Account",
                              subtitle:
                                  "Join the premiere community for cinema lovers",
                            ),
                            AppSpacing.verticalSpacing(25),
                            AuthFormContainer(
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
                                      validator: (v) => v == null || v.isEmpty
                                          ? "Name is required"
                                          : null,
                                    ),
                                  ),
                                  AppSpacing.verticalSpacing(AppSpacing.l),
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
                                  AppSpacing.verticalSpacing(AppSpacing.l),
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
                            AppSpacing.verticalSpacing(30),
                            _SignUpButton(
                              formKey: formKey,
                              nameController: nameController,
                              emailController: emailController,
                              passwordController: passwordController,
                            ),
                            AppSpacing.verticalSpacing(30),
                            const AuthDivider(),
                            AppSpacing.verticalSpacing(20),
                            SocialButtonsRow(),
                            AppSpacing.verticalSpacing(25),
                            const _LoginToggle(),
                            AppSpacing.verticalSpacing(20),
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
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

class _LoginToggle extends StatelessWidget {
  const _LoginToggle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already a member? ", style: TextStyles.font12RegularCoolGrayManrope),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            "Sign In",
            style: TextStyles.font13BoldNeonBlueSora.copyWith(
              fontWeight: Weights.extraBold,
            ),
          ),
        ),
      ],
    );
  }
}
