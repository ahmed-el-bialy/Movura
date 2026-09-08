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
      padding: AppSpacing.only(bottom: 14, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 64.h,
            padding: AppSpacing.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              color: AppColors.jetBlack.withValues(alpha: 0.75),
              border: Border.all(
                color: AppColors.slateGray.withValues(alpha: 0.25),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(28.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(
                    label: 'Home',
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
                    label: 'Search',
                    activeIcon: Icons.search_rounded,
                    isActive: activeIndex == 1,
                    onTap: () => _openSearch(context),
                  ),
                  NavItem(
                    label: 'Library',
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
                    label: 'Profile',
                    activeIcon: Icons.person_rounded,
                    inActiveIcon: Icons.person_outline_rounded,
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
