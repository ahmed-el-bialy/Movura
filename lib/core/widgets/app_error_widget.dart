import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/app_text_button.dart';

import '../helpers/spacing.dart';
import '../theming/app_colors.dart';
import '../theming/text_styles.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  final String errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.softRed.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.softRed,
                size: 60.sp,
              ),
            ),
            verticalSpacing(24),
            Text(
              "Something went wrong",
              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                fontSize: 20.sp,
                color: AppColors.pureWhite,
              ),
            ),
            verticalSpacing(8),
            Text(
              errorMessage,
              style: TextStyles.font14PureWhiteManrope.copyWith(
                color: AppColors.coolGray,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              verticalSpacing(32),
              AppTextButton(
                buttonText: 'RETRY',
                onPressed: onRetry!,
                buttonWidth: 160,
                buttonHeight: 45,
                borderRadius: 12,
                textStyle: TextStyles.font17BoldTrueBlackSora.copyWith(
                  fontSize: 14.sp,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
