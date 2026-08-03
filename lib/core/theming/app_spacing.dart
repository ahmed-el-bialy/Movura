import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized spacing system for Movura
abstract class AppSpacing {
  // Basic spacing scale (design units)
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;

  // SizedBox spacing helpers
  static SizedBox verticalSpacing(double height) => SizedBox(height: height.h);

  static SizedBox horizontalSpacing(double width) => SizedBox(width: width.w);

  // Sliver spacing helpers
  static SliverToBoxAdapter sliverHorizontalSpacing(double width) =>
      SliverToBoxAdapter(child: SizedBox(width: width.w));

  static SliverToBoxAdapter sliverVerticalSpacing(double height) =>
      SliverToBoxAdapter(child: SizedBox(height: height.h));

  // Common EdgeInsets helpers
  static EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value.w);

  static EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: value.h);

  static EdgeInsets all(double value) => EdgeInsets.all(value.r);

  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);

  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: left.w,
    top: top.h,
    right: right.w,
    bottom: bottom.h,
  );

  // Convenience shortcuts
  static EdgeInsets horizontal16() => horizontal(l);

  static EdgeInsets symmetric16x12() => symmetric(horizontal: l, vertical: m);
}
