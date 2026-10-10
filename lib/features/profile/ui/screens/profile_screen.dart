import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/features/auth/data/repos/auth_repo.dart';
import 'package:movura/features/auth/data/web_services/auth_services.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';
import 'package:movura/features/profile/ui/widgets/dialogs/delete_account_dialog.dart';
import 'package:movura/features/profile/ui/widgets/profile_collection_tile.dart';
import 'package:movura/features/profile/ui/widgets/profile_header.dart';
import 'package:movura/features/profile/ui/widgets/profile_section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = sl<AuthServices>().currentUser;
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
                    ProfileHeader(displayName: displayName, email: email),
                    AppSpacing.verticalSpacing(40),
                    const ProfileSectionHeader(title: 'YOUR COLLECTIONS'),
                    AppSpacing.verticalSpacing(AppSpacing.l),
                    ProfileCollectionTile(
                      title: 'Favorites',
                      count: userModel?.favorites?.length ?? 0,
                      icon: Icons.favorite_border_rounded,
                      color: AppColors.softRed,
                      onTap: () {},
                    ),
                    ProfileCollectionTile(
                      title: 'To Watch',
                      count: userModel?.toWatch?.length ?? 0,
                      icon: Icons.bookmark_outline_rounded,
                      color: AppColors.neonBlue,
                      onTap: () {},
                    ),
                    ProfileCollectionTile(
                      title: 'Watched History',
                      count: userModel?.watched?.length ?? 0,
                      icon: Icons.check_circle_outline_rounded,
                      color: AppColors.tealCyan,
                      onTap: () {},
                    ),
                    ProfileCollectionTile(
                      title: 'Watch It Now',
                      count: userModel?.watchNow?.length ?? 0,
                      icon: Icons.play_circle_outline_rounded,
                      color: AppColors.amberGold,
                      onTap: () {},
                    ),
                    AppSpacing.verticalSpacing(30),
                    const ProfileSectionHeader(title: 'SETTINGS'),
                    AppSpacing.verticalSpacing(AppSpacing.l),
                    ProfileCollectionTile(
                      title: 'App Settings',
                      icon: Icons.settings_outlined,
                      color: AppColors.slateGray,
                      onTap: () {},
                    ),
                    ProfileCollectionTile(
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
                      ProfileCollectionTile(
                        title: 'Delete Account',
                        icon: Icons.delete_forever_rounded,
                        color: AppColors.softRed,
                        onTap: () => DeleteAccountDialog.show(context),
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
}
