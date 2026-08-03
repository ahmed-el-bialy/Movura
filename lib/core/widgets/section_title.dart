import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.sectionName,
    this.actionName,
    this.titleStyle,
    this.actionStyle,
    this.onTap,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final String sectionName;
  final String? actionName;
  final TextStyle? titleStyle;
  final TextStyle? actionStyle;
  final GestureTapCallback? onTap;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding?.w ?? 8.w,
        vertical: verticalPadding?.w ?? 6.h,
      ),
      child: Row(
        children: [
          Text(
            sectionName,
            style: titleStyle ?? TextStyles.font20SimiBoldPlatinumGray,
          ),
          Spacer(flex: 1),
          actionName != null
              ? GestureDetector(
                  onTap: onTap ?? () {},
                  child: Text(
                    actionName!,
                    style: actionStyle ?? TextStyles.font13MediumNeonBlue,
                  ),
                )
              : Spacer(flex: 1),
        ],
      ),
    );
  }
}
