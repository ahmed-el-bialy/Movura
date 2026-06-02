import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.sectionName,
    this.actionName,
    this.titleStyle,
    this.actionStyle,
    this.onTap,
  });

  final String sectionName;
  final String? actionName;
  final TextStyle? titleStyle;
  final TextStyle? actionStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Row(
        children: [
          Text(
            sectionName,
            style: titleStyle ?? Styles.font20SimiBoldPlatinumGray,
          ),
          Spacer(flex: 1),
          actionName != null
              ? GestureDetector(
                  onTap: onTap ?? () {},
                  child: Text(
                    actionName!,
                    style: actionStyle ?? Styles.font13MediumNeonCyan,
                  ),
                )
              : Spacer(flex: 1),
        ],
      ),
    );
  }
}
