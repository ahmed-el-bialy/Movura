import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/networking/di.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../search/logic/search/search_cubit.dart';
import '../../../search/ui/screens/custom_search_delegate.dart';

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
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppConstants.appLogo, height: 40.h),
          horizontalSpacing(12),
          Text(
            AppConstants.appName,
            style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
              fontSize: 20.sp,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: AppIconButton(
            icon: Icons.search_outlined,
            onPressed: () {
              final searchCubit = sl<SearchCubit>();
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchCubit: searchCubit),
              );
            },
            iconColor: AppColors.slateGray,
            size: 26,
          ),
        ),
      ],
    );
  }
}
