import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
