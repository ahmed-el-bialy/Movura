import 'package:flutter/material.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

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
      padding: AppSpacing.symmetric(
        horizontal: horizontalPadding ?? AppSpacing.s,
        vertical: verticalPadding ?? 6,
      ),
      child: Row(
        children: [
          Text(
            sectionName,
            style: titleStyle ?? TextStyles.font20SemiBoldPlatinumGray,
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
