import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/helpers/validators.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/buttons/app_text_button.dart';
import 'package:movura/core/widgets/fields/app_text_form_field.dart';
import '../../logic/auth/auth_cubit.dart';
import 'auth_prefix_icon.dart';

/// Premium glassmorphic bottom sheet for password recovery.
/// Features high-end animations and integrated logic.
class ForgotPasswordSheet extends StatefulWidget {
  final String? initialEmail;

  const ForgotPasswordSheet({super.key, this.initialEmail});

  static Future<void> show(BuildContext context, {String? email}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (_) => ForgotPasswordSheet(initialEmail: email),
    );
  }

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().resetPassword(_emailController.text.trim());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Reset link sent to ${_emailController.text}"),
          backgroundColor: AppColors.profitGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: AppSpacing.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.charcoalBlack.withValues(alpha: 0.85),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              border: Border.all(
                color: AppColors.pureWhite.withValues(alpha: 0.08),
                width: 1.5,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Handle
                  Container(
                    width: 45.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.slateGray.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ).animate().fadeIn(delay: 200.ms).moveY(begin: -10, end: 0),

                  AppSpacing.verticalSpacing(AppSpacing.xl),

                  Text(
                    "Recover Password",
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 22.sp,
                      letterSpacing: 0.5,
                    ),
                  ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.9, 0.9)),

                  AppSpacing.verticalSpacing(10),

                  Text(
                    "We'll send a cinematic recovery link to your email inbox.",
                    textAlign: TextAlign.center,
                    style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.coolGray.withValues(alpha: 0.7),
                    ),
                  ).animate().fadeIn(delay: 450.ms),

                  AppSpacing.verticalSpacing(32),

                  AppTextFormField(
                    controller: _emailController,
                    hintText: AppConstants.emailExample,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: const AuthPrefixIcon(icon: Icons.alternate_email_rounded),
                    validator: Validators.validateEmail,
                  ).animate().fadeIn(delay: 600.ms).moveX(begin: -20, end: 0),

                  AppSpacing.verticalSpacing(36),

                  AppTextButton(
                    buttonText: "SEND RECOVERY LINK",
                    onPressed: _handleReset,
                    buttonWidth: double.infinity,
                    buttonHeight: 52.h,
                    borderRadius: 16.r,
                    textStyle: TextStyles.font17BoldTrueBlackSora.copyWith(
                      fontSize: 15.sp,
                      letterSpacing: 1.2,
                    ),
                  ).animate().fadeIn(delay: 750.ms).moveY(begin: 20, end: 0),
                  
                  AppSpacing.verticalSpacing(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
