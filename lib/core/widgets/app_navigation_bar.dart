import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/sub_widgets/nav_item.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/custom_search_delegate.dart';

class AppNavigationBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTabChanged;

  const AppNavigationBar({
    super.key,
    required this.activeIndex,
    this.onTabChanged,
  });

  void _openSearch(BuildContext context) {
    if (onTabChanged != null) {
      onTabChanged!(1);
    } else {
      showSearch(
        context: context,
        delegate: CustomSearchDelegate(searchCubit: sl<SearchCubit>()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 18.w, right: 18.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 62.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: AppColors.jetBlack.withValues(alpha: .6),
              border: Border.all(
                color: AppColors.slateGray.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(
                    icon: Icons.home_rounded,
                    isActive: activeIndex == 0,
                    onTap: () {
                      if (onTabChanged != null) {
                        onTabChanged!(0);
                      }
                    },
                  ),
                  NavItem(
                    icon: Icons.search_rounded,
                    isActive: activeIndex == 1,
                    onTap: () => _openSearch(context),
                  ),
                  NavItem(
                    icon: Icons.format_list_bulleted_rounded,
                    isActive: activeIndex == 2,
                    onTap: () {
                      if (onTabChanged != null) {
                        onTabChanged!(2);
                      }
                    },
                  ),
                  NavItem(
                    icon: Icons.person_rounded,
                    isActive: activeIndex == 3,
                    onTap: () {
                      if (onTabChanged != null) {
                        onTabChanged!(3);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
