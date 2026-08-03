import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class ReadMoreText extends StatefulWidget {
  const ReadMoreText({
    super.key,
    required this.content,
    this.style,
    this.maxLines,
  });

  final String content;
  final TextStyle? style;
  final int? maxLines;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final int defaultMaxLines = widget.maxLines ?? 3;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.content,
            style:
                widget.style ??
                TextStyles.font14BoldIceBlueMontserrat.copyWith(
                  color: AppColors.pureWhite.withValues(alpha: 0.9),
                  fontWeight: Weights.semiBold,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
          ),
          maxLines: defaultMaxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isTextLong = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.content,
              style:
                  widget.style ??
                  TextStyles.font14BoldIceBlueMontserrat.copyWith(
                    color: AppColors.pureWhite.withValues(alpha: 0.85),
                    fontWeight: Weights.regular,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
              maxLines: isExpanded ? null : defaultMaxLines,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (isTextLong)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: AppSpacing.vertical(AppSpacing.xs),
                  child: Text(
                    isExpanded ? "Read Less" : "Read More",
                    style: TextStyles.font13BoldNeonBlueSora.copyWith(
                      fontSize: 12.sp,
                      fontWeight: Weights.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
