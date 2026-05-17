import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(size: 28.sp),
      unselectedIconTheme: IconThemeData(size: 28.sp),
      backgroundColor: AppColors.eerieBlack,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.neonCyan,
      unselectedItemColor: AppColors.slateGray,
      currentIndex: 0,
      onTap: (int index) {},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted_rounded),
          label: "library",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: "profile",
        ),
      ],
    );
  }
}
