import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/features/auth/data/repos/auth_repo.dart';
import 'package:movura/features/auth/data/web_services/auth_services.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = sl<AuthServices>().currentUser;
    // Prefer the name from Firestore userModel (updated on social sign-in)
    // Fall back to Firebase Auth displayName, then a friendly default
    final String displayName = currentUser?.displayName?.isNotEmpty == true
        ? currentUser!.displayName!
        : 'Cinematic Explorer';
    final String email = currentUser?.email ?? 'Guest User';

    return Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: AppSpacing.horizontal(20),
              child: BlocBuilder<LibraryCubit, LibraryState>(
                builder: (context, state) {
                  final userModel = state is LibraryLoaded ? state.userModel : null;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.verticalSpacing(30),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.onyxBlack,
                                border: Border.all(
                                  color: AppColors.neonBlue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonBlue.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_rounded,
                                size: 60.sp,
                                color: AppColors.neonBlue,
                              ),
                            ),
                            AppSpacing.verticalSpacing(AppSpacing.l),
                            Text(
                              displayName,
                              style: TextStyles.font24SemiBoldNeonBlueManrope
                                  .copyWith(color: AppColors.iceBlue),
                            ),
                            AppSpacing.verticalSpacing(4),
                            Text(
                              email,
                              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                                color: AppColors.coolGray.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalSpacing(40),
                      Text(
                        'YOUR COLLECTIONS',
                        style: TextStyles.font10BoldCoolGray.copyWith(
                          letterSpacing: 1.5,
                          color: AppColors.neonBlue.withValues(alpha: 0.7),
                        ),
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      _ProfileCollectionTile(
                        title: 'Favorites',
                        count: userModel?.favorites?.length ?? 0,
                        icon: Icons.favorite_border_rounded,
                        color: AppColors.softRed,
                        onTap: () {},
                      ),
                      _ProfileCollectionTile(
                        title: 'To Watch',
                        count: userModel?.toWatch?.length ?? 0,
                        icon: Icons.bookmark_outline_rounded,
                        color: AppColors.neonBlue,
                        onTap: () {},
                      ),
                      _ProfileCollectionTile(
                        title: 'Watched History',
                        count: userModel?.watched?.length ?? 0,
                        icon: Icons.check_circle_outline_rounded,
                        color: AppColors.tealCyan,
                        onTap: () {},
                      ),
                      _ProfileCollectionTile(
                        title: 'Watch It Now',
                        count: userModel?.watchNow?.length ?? 0,
                        icon: Icons.play_circle_outline_rounded,
                        color: AppColors.amberGold,
                        onTap: () {},
                      ),
                      AppSpacing.verticalSpacing(30),
                      Text(
                        'SETTINGS',
                        style: TextStyles.font10BoldCoolGray.copyWith(
                          letterSpacing: 1.5,
                          color: AppColors.neonBlue.withValues(alpha: 0.7),
                        ),
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      _ProfileCollectionTile(
                        title: 'App Settings',
                        icon: Icons.settings_outlined,
                        color: AppColors.slateGray,
                        onTap: () {},
                      ),
                      _ProfileCollectionTile(
                        title: currentUser != null ? 'Log Out' : 'Sign In',
                        icon: currentUser != null
                            ? Icons.logout_rounded
                            : Icons.login_rounded,
                        color: currentUser != null
                            ? AppColors.slateGray
                            : AppColors.neonBlue,
                        onTap: () async {
                          if (currentUser != null) {
                            await sl<AuthRepo>().logOut();
                            if (context.mounted) {
                              context.pushAndRemoveUntil(
                                routeName: RouteNames.logInScreen,
                              );
                            }
                          } else {
                            context.pushNamed(RouteNames.logInScreen);
                          }
                        },
                      ),
                      if (currentUser != null)
                        _ProfileCollectionTile(
                          title: 'Delete Account',
                          icon: Icons.delete_forever_rounded,
                          color: AppColors.softRed,
                          onTap: () => _showDeleteAccountDialog(context),
                        ),
                      AppSpacing.verticalSpacing(100),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
              "Delete Account?",
              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                fontSize: 18.sp,
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to permanently delete your account and all your saved collections? This action cannot be undone.",
          style: TextStyles.font12RegularCoolGrayManrope.copyWith(
            color: AppColors.coolGray,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.coolGray, fontSize: 13.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                final authServices = sl<AuthServices>();
                final uid = authServices.currentUser?.uid;
                if (uid != null) {
                  await authServices.deleteUserData(uid: uid);
                }
                await authServices.currentUser?.delete();
                await authServices.signOut();
                if (context.mounted) {
                  context.pushAndRemoveUntil(
                    routeName: RouteNames.logInScreen,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Your account has been deleted."),
                      backgroundColor: AppColors.softRed,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to delete account: ${e.toString()}"),
                      backgroundColor: AppColors.softRed,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softRed,
              foregroundColor: AppColors.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "Delete",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCollectionTile extends StatelessWidget {
  const _ProfileCollectionTile({
    required this.title,
    this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final int? count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.only(bottom: 12),
      child: Material(
        color: AppColors.onyxBlack.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSpacing.l),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.l),
          child: Container(
            padding: AppSpacing.all(AppSpacing.l),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.l),
              border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: AppSpacing.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 22.sp),
                ),
                AppSpacing.horizontalSpacing(AppSpacing.l),
                Text(
                  title,
                  style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                    fontWeight: Weights.semiBold,
                  ),
                ),
                const Spacer(),
                if (count != null)
                  Text(
                    '$count',
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.coolGray,
                    ),
                  ),
                AppSpacing.horizontalSpacing(AppSpacing.s),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.coolGray.withValues(alpha: 0.5),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
