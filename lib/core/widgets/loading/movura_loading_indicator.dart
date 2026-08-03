import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'package:movura/core/theming/app_colors.dart';

/// MOVURA animated loading indicator widget.
/// Draws the "M" logo forward (Left -> Right) and erases in reverse (Right -> Left).
class MovuraLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double strokeWidth;
  final bool showOuterRing;

  const MovuraLoadingIndicator({
    super.key,
    this.size = 140,
    this.color = AppColors.neonBlue,
    this.duration = const Duration(milliseconds: 2300),
    this.strokeWidth = 28,
    this.showOuterRing = true,
  });

  @override
  State<MovuraLoadingIndicator> createState() =>
      _MovuraLoadingIndicatorState();
}

class _MovuraLoadingIndicatorState extends State<MovuraLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Path _logoPath;

  // SVG Path data representing the centerline stroke of the "M" logo
  static const String _rawPathData =
      'M 148.80 389.44 C 148.85 358.51 148.43 242.35 149.12 203.84 C 149.81 165.33 150.83 168.80 152.96 158.40 C 155.09 148.00 158.77 145.81 161.92 141.44 C 165.07 137.07 168.11 134.77 171.84 132.16 C 175.57 129.55 178.67 127.36 184.32 125.76 C 189.97 124.16 201.12 122.83 205.76 122.56 C 210.40 122.29 210.83 122.99 212.16 124.16 C 213.49 125.33 213.39 117.07 213.76 129.60 C 214.13 142.13 213.65 184.53 214.40 199.36 C 215.15 214.19 215.63 212.05 218.24 218.56 C 220.85 225.07 226.35 233.17 230.08 238.40 C 233.81 243.63 236.43 247.31 240.64 249.92 C 244.85 252.53 250.19 254.29 255.36 254.08 C 260.53 253.87 267.41 251.25 271.68 248.64 C 275.95 246.03 277.55 243.25 280.96 238.40 C 284.37 233.55 289.55 226.13 292.16 219.52 C 294.77 212.91 295.89 213.12 296.64 198.72 C 297.39 184.32 296.32 145.44 296.64 133.12 C 296.96 120.80 297.23 126.56 298.56 124.80 C 299.89 123.04 299.47 122.24 304.64 122.56 C 309.81 122.88 323.15 124.64 329.60 126.72 C 336.05 128.80 339.68 132.00 343.36 135.04 C 347.04 138.08 349.23 140.75 351.68 144.96 C 354.13 149.17 356.48 154.13 358.08 160.32 C 359.68 166.51 360.53 143.89 361.28 182.08 C 362.03 220.27 362.35 354.88 362.56 389.44';

  @override
  void initState() {
    super.initState();
    _logoPath = parseSvgPathData(_rawPathData);
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _MLogoPainter(
              path: _logoPath,
              progress: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              showOuterRing: widget.showOuterRing,
            ),
          );
        },
      ),
    );
  }
}

class _MLogoPainter extends CustomPainter {
  final Path path;
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool showOuterRing;

  _MLogoPainter({
    required this.path,
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.showOuterRing,
  });

  double _easeInOutQuad(double t) {
    return t < 0.5 ? 2 * t * t : 1 - ((-2 * t + 2) * (-2 * t + 2)) / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 6;

    // ================= 1. Outer Ring & Rotating Arc =================
    if (showOuterRing) {
      final trackPaint = Paint()
        ..color = AppColors.pureWhite.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawCircle(center, radius, trackPaint);

      final spinnerPaint = Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      final startAngle = progress * 2 * math.pi;
      const sweepAngle = math.pi / 2.5;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        spinnerPaint,
      );
    }

    // ================= 2. Centered "M" Logo =================
    final pathBounds = path.getBounds();
    final fitSize = showOuterRing ? size.width * 0.55 : size.width * 0.75;

    final scale = math.min(
      fitSize / pathBounds.width,
      fitSize / pathBounds.height,
    );

    canvas.save();

    // Center the actual bounds of the M path dynamically in the Canvas
    canvas.translate(
      (size.width - pathBounds.width * scale) / 2 - pathBounds.left * scale,
      (size.height - pathBounds.height * scale) / 2 - pathBounds.top * scale,
    );
    canvas.scale(scale, scale);

    // Subtle Ghost Outline
    final ghostPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, ghostPaint);

    // Active Draw Paint
    final drawPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Timeline phases:
    // 0.0 - 0.45 : Forward Draw (0.0 -> 1.0)
    // 0.45 - 0.55: Hold full path
    // 0.55 - 0.95: Reverse Rewind/Erase (1.0 -> 0.0) from end back to start
    // 0.95 - 1.00: Empty Pause
    const double drawEnd = 0.45;
    const double holdEnd = 0.55;
    const double eraseEnd = 0.95;

    double startFraction = 0.0;
    double endFraction = 0.0;

    if (progress < drawEnd) {
      // Phase 1: Draw forward (0 to 1)
      final t = _easeInOutQuad(progress / drawEnd);
      startFraction = 0.0;
      endFraction = t;
    } else if (progress < holdEnd) {
      // Phase 2: Hold fully drawn
      startFraction = 0.0;
      endFraction = 1.0;
    } else if (progress < eraseEnd) {
      // Phase 3: Flashback / Reverse Erase back from 1.0 to 0.0
      final t = _easeInOutQuad((progress - holdEnd) / (eraseEnd - holdEnd));
      startFraction = 0.0;
      endFraction = 1.0 - t; // Shrinks back to zero from the right side
    } else {
      // Phase 4: Pause empty
      startFraction = 0.0;
      endFraction = 0.0;
    }

    // Extract animated path segment
    if (startFraction < endFraction) {
      for (final metric in path.computeMetrics()) {
        final extracted = metric.extractPath(
          metric.length * startFraction,
          metric.length * endFraction,
        );
        canvas.drawPath(extracted, drawPaint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MLogoPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.showOuterRing != showOuterRing;
  }
}