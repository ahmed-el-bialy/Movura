import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/context_extension.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/auth/data/web_services/auth_services.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) => const DeleteAccountDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.charcoalBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: AppColors.softRed.withValues(alpha: 0.4)),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.softRed, size: 24.sp),
          SizedBox(width: 8.w),
          Text(
            'Delete Account?',
            style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
              fontSize: 18.sp,
              color: AppColors.pureWhite,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to permanently delete your account and all your saved collections? This action cannot be undone.',
        style: TextStyles.font12RegularCoolGrayManrope.copyWith(
          color: AppColors.coolGray,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.coolGray, fontSize: 13.sp),
          ),
        ),
        ElevatedButton(
          onPressed: () => _onDeleteAccountPressed(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.softRed,
            foregroundColor: AppColors.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<void> _onDeleteAccountPressed(BuildContext context) async {
    context.pop();
    try {
      final authServices = sl<AuthServices>();
      final uid = authServices.currentUser?.uid;
      if (uid != null) {
        await authServices.deleteUserData(uid: uid);
      }
      await authServices.currentUser?.delete();
      await authServices.signOut();
      if (context.mounted) {
        context.pushAndRemoveUntil(routeName: RouteNames.logInScreen);
        context.showSnackBar(
          'Your account has been deleted.',
          backgroundColor: AppColors.softRed,
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar(
          'Failed to delete account: ${e.toString()}',
          backgroundColor: AppColors.softRed,
        );
      }
    }
  }
}
