import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class GlassLogoEmblem extends StatelessWidget {
  const GlassLogoEmblem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.r,
      height: 130.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130.r,
            height: 130.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonBlue.withValues(alpha: 0.35),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
              gradient: RadialGradient(
                colors: [
                  AppColors.neonBlue.withValues(alpha: 0.12),
                  AppColors.darkNeonCyan.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 110.r,
                height: 110.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.richEerieBlack.withValues(alpha: 0.55),
                  border: Border.all(
                    color: AppColors.neonBlue.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: Size(58.r, 58.r),
                    painter: _MLetterPainter(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MLetterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const strokeW = 5.5;
    const r = 10.0;

    final paint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1.0);

    final w = size.width;
    final h = size.height;

    final leftLeg = Path()
      ..moveTo(w * 0.12, h * 0.05)
      ..lineTo(w * 0.12, h * 0.82)
      ..arcToPoint(
        Offset(w * 0.12 + r, h * 0.82 + r),
        radius: const Radius.circular(r),
        clockwise: true,
      );

    final leftDiag = Path()
      ..moveTo(w * 0.12, h * 0.05)
      ..lineTo(w * 0.50, h * 0.52);

    final rightDiag = Path()
      ..moveTo(w * 0.50, h * 0.52)
      ..lineTo(w * 0.88, h * 0.05);

    final rightLeg = Path()
      ..moveTo(w * 0.88, h * 0.05)
      ..lineTo(w * 0.88, h * 0.82)
      ..arcToPoint(
        Offset(w * 0.88 - r, h * 0.82 + r),
        radius: const Radius.circular(r),
        clockwise: false,
      );

    final glowPaint = Paint()
      ..color = AppColors.neonBlue.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW + 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    for (final path in [leftLeg, leftDiag, rightDiag, rightLeg]) {
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
