import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/buttons/app_icon_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: AppColors.transparent),
        ),
      ),
      leading: Builder(
        builder: (context) {
          return AppIconButton(
            icon: Icons.notes,
            onPressed: () => Scaffold.of(context).openDrawer(),
            size: 30,
          );
        },
      ),
      centerTitle: true,
      backgroundColor: AppColors.richEerieBlack.withValues(alpha: 0.8),
      title: Text(
        AppConstants.appName,
        style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
          fontSize: 22.sp,
          letterSpacing: 4,
          fontWeight: FontWeight.w900,
        ),
      ),
      actions: [
        Padding(
          padding: AppSpacing.only(right: 15),
          child: Image.asset(AppConstants.appLogo, height: 32.h),
        ),
      ],
    );
  }
}
