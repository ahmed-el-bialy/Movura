import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppSpacing provides centralized spacing tokens and helper EdgeInsets
/// builders that work with ScreenUtil scaling. Use the helpers from
/// within widget build methods (after ScreenUtilInit has run).
class AppSpacing {
  // Basic spacing scale (design units)
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;

  // Numeric values (use with .w/.h/.r when needed)
  static double h(double value) => value;
  static double v(double value) => value;

  // Common EdgeInsets helpers (call after ScreenUtilInit)
  static EdgeInsets horizontal(double value) => EdgeInsets.symmetric(horizontal: value.w);
  static EdgeInsets vertical(double value) => EdgeInsets.symmetric(vertical: value.h);
  static EdgeInsets all(double value) => EdgeInsets.all(value.r);
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);

  // Convenience shortcuts for commonly used paddings
  static EdgeInsets horizontal16() => horizontal(l);
  static EdgeInsets symmetric16x12() => symmetric(horizontal: l, vertical: m);
}
