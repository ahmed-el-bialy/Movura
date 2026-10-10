import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/buttons/app_text_button.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

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
          'Skip',
          style: TextStyles.font13MediumNeonBlue.copyWith(fontSize: 12.sp),
        ),
      ),
    );
  }
}

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    super.key,
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
            buttonText: state is AuthLoading ? 'AUTHENTICATING...' : 'LOGIN',
            onPressed: state is AuthLoading
                ? null
                : () {
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

class SignUpToggleOption extends StatelessWidget {
  const SignUpToggleOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New here? ', style: TextStyles.font12RegularCoolGrayManrope),
        GestureDetector(
          onTap: () => context.pushNamed(RouteNames.signUpScreen),
          child: Text(
            'Create Account',
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
