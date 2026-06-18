import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSocialButton extends StatelessWidget {
  const BuildSocialButton({
    super.key,
    required this.assetPath,
    required this.backgroundColor,
    required this.onTap,
  });

  final String assetPath;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Image.asset(assetPath, width: 24.w, height: 24.w),
        ),
      ),
    );
  }
}
