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
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Text(
            sectionName,
            style: titleStyle ?? Styles.font20platinumGraySimiBold,
          ),
        ),
        Spacer(flex: 1),
        actionName != null
            ? GestureDetector(
                onTap: onTap ?? () {},
                child: Text(
                  actionName!,
                  style: actionStyle ?? Styles.font10NeonCyanMedium,
                ),
              )
            : Spacer(flex: 1),
      ],
    );
  }
}
