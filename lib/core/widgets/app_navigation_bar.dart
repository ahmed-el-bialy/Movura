import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';

import '../theming/colors.dart';
import '../utils/constants/strings.dart';

class AppNavigationBar extends StatelessWidget {
  final int activeIndex;

  const AppNavigationBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 18.w, right: 18.w),
      child: Container(
        height: 62.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.jetBlack.withValues(alpha: .8),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: AppColors.neonBlue.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  if (activeIndex != 0) {
                    context.pushReplacementNamed(Strings.mainScreen, null);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Icon(
                    Icons.home_rounded,
                    size: 28.sp,
                    color: activeIndex == 0
                        ? AppColors.neonBlue
                        : AppColors.slateGray,
                  ),
                ),
              ),

              InkWell(
                splashColor: AppColors.neonBlue.withValues(alpha: .4),
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  // هنا هتحط الـ Route بتاع شاشة الـ Library
                  // if (activeIndex != 2) context.pushReplacementNamed(Strings.libraryScreen, null);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Icon(
                    Icons.format_list_bulleted_rounded,
                    size: 28.sp,
                    color: activeIndex == 2
                        ? AppColors.neonBlue
                        : AppColors.slateGray,
                  ),
                ),
              ),
              // أيقونة Library -> index = 2
              InkWell(
                splashColor: AppColors.neonBlue.withValues(alpha: .45),
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  // هنا هتحط الـ Route بتاع شاشة الـ Assistant
                  // if (activeIndex != 3) context.pushReplacementNamed(Strings.assistantScreen, null);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Icon(
                    Icons.psychology_outlined,
                    size: 28.sp,
                    color: activeIndex == 3
                        ? AppColors.neonBlue
                        : AppColors.slateGray,
                  ),
                ),
              ),
              InkWell(
                splashColor: AppColors.neonBlue.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  // هنا هتحط الـ Route بتاع شاشة البحث لما تعملها
                  // if (activeIndex != 1) context.pushReplacementNamed(Strings.searchScreen, null);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Icon(
                    Icons.person_rounded,
                    size: 28.sp,
                    color: activeIndex == 1
                        ? AppColors.neonBlue
                        : AppColors.slateGray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
