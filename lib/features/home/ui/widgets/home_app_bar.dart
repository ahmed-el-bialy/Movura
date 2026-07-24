import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/networking/di.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../search/logic/search/search_cubit.dart';
import '../../../search/ui/custom_search_delegate.dart';

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
          child: Container(color: Colors.transparent),
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
      backgroundColor: AppColors.eerieBlack.withValues(alpha: 0.6),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Image.asset(
              AppConstants.appLogo,
              fit: BoxFit.fill,
              height: 30.h,
              width: 30.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              AppConstants.appName,
              style: AppTextStyles.font24SimiBoldNeonBlueManrope,
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
