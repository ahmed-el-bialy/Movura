

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.softRed,
              size: 50.sp,
            ),
            verticalSpacing(16),
            Text(
              errorMessage,
              style: TextStyles.font14PureWhiteManrope.copyWith(
                color: AppColors.coolGray,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              verticalSpacing(20),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'RETRY',
                  style: TextStyles.font17BoldTrueBlackSora.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
