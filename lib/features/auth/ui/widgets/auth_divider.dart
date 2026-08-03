import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.slateGray.withValues(alpha: 0.2)),
        ),
        Padding(
          padding: AppSpacing.horizontal(AppSpacing.l),
          child: Text(
            "OR CONTINUE WITH",
            style: TextStyles.font12BoldCoolGray.copyWith(
              fontSize: 11.sp,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.slateGray.withValues(alpha: 0.2)),
        ),
      ],
    );
  }
}
