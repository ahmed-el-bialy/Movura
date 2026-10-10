import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/buttons/app_text_button.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';

class SignUpSubmitButton extends StatelessWidget {
  const SignUpSubmitButton({
    super.key,
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
                ? 'CREATING ACCOUNT...'
                : 'SIGN UP',
            onPressed: state is AuthLoading
                ? null
                : () {
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

class LoginToggleOption extends StatelessWidget {
  const LoginToggleOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already a member? ',
          style: TextStyles.font12RegularCoolGrayManrope,
        ),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            'Sign In',
            style: TextStyles.font13BoldNeonBlueSora.copyWith(
              fontWeight: Weights.extraBold,
            ),
          ),
        ),
      ],
    );
  }
}
