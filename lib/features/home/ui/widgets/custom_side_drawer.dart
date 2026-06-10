import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/constants/strings.dart';

class CustomSideDrawer extends StatelessWidget {
  const CustomSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.richEerieBlack,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.charcoalBlack,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.coolGray.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image.asset(
                      "assets/images/mini_icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      Strings.appName,
                      style: TextStyle(
                        color: AppColors.neonCyan,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.person, color: AppColors.coolGray),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star, color: AppColors.coolGray),
            title: const Text('Go Pro', style: TextStyle(color: Colors.white)),
            trailing: Icon(
              Icons.auto_awesome,
              color: AppColors.neonCyan,
              size: 22.sp,
            ),
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
