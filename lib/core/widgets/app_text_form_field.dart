import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';

import '../theming/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.prefixIcon,
  });

  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inputTextStyle ?? AppTextStyles.font14SimiBoldPlatinumGraySora,
      obscureText: isObscureText ?? false,

      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor ?? AppColors.charcoalBlack,
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        hintStyle: hintStyle ?? AppTextStyles.font16SimiBoldPlatinumGray,

        hint: Text(
          hintText,
          style: AppTextStyles.font10BoldCoolGray.copyWith(
            fontSize: 16.sp,
            color: AppTextStyles.font10BoldCoolGray.color?.withValues(
              alpha: .6,
            ),
          ),
        ),

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,

        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.coolGray, width: 1.3.w),
            ),

        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red, width: 1.3.w),
            ),

        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.neonBlue, width: 1.3.w),
            ),
      ),
    );
  }
}
