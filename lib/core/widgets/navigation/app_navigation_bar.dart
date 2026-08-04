import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/screens/custom_search_delegate.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import '../../networking/di.dart';
import 'navigation_widgets/nav_item.dart';

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
      padding: AppSpacing.only(bottom: 10, left: 18, right: 18),
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
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(25.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(
                    activeIcon: Icons.home_rounded,
                    inActiveIcon: Icons.home_outlined,
                    isActive: activeIndex == 0,
                    onTap: () {
                      if (onTabChanged != null) {
                        onTabChanged!(0);
                      }
                    },
                  ),
                  NavItem(
                    activeIcon: Icons.search_rounded,
                    isActive: activeIndex == 1,
                    onTap: () => _openSearch(context),
                  ),
                  NavItem(
                    activeIcon: Icons.collections_bookmark_rounded,
                    inActiveIcon: Icons.collections_bookmark_outlined,
                    isActive: activeIndex == 2,
                    onTap: () {
                      if (onTabChanged != null) {
                        onTabChanged!(2);
                      }
                    },
                  ),
                  NavItem(
                    activeIcon: Icons.person_rounded,
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
