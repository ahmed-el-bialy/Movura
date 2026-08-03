import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/spacing.dart';
import '../theming/app_colors.dart';
import '../theming/text_styles.dart';

class EmptySectionMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final bool showIcon;
  final int? heightPage;

  const EmptySectionMessage({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.showIcon = true,
    this.heightPage = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightPage?.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.neonBlue, size: 50.sp),
          verticalSpacing(16),
          Text(title, style: TextStyles.font20SimiBoldNeonBlueManrope),
          verticalSpacing(8),
          subTitle != null
              ? Text(subTitle!, style: TextStyles.font12MediumPlatinumGray)
              : const SizedBox(),
        ],
      ),
    );
  }
}
