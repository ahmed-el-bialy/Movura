import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/networking/di.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../search/logic/search/search_cubit.dart';
import '../../../search/ui/custom_search_delegate.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.notes, color: AppColors.neonBlue, size: 30.sp),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      centerTitle: true,
      backgroundColor: AppColors.eerieBlack,
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
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: InkWell(
            splashColor: AppColors.neonBlue.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              final searchCubit = sl<SearchCubit>();
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchCubit: searchCubit),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Icon(
                Icons.search_outlined,
                size: 26.sp,
                color: AppColors.slateGray,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
