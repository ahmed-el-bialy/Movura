import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.richEerieBlack.withValues(alpha: 0.8),
              elevation: 0,
              title: Text(
                'My Library',
                style: AppTextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                  fontSize: 22.sp,
                ),
              ),
              centerTitle: false,
            ),
            sliverVerticalSpacing(16),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildListDelegate([
                  _LibraryCard(
                    title: 'Watchlist',
                    count: 12,
                    icon: Icons.bookmark_outline_rounded,
                    color: AppColors.neonBlue,
                    onTap: () {},
                  ),
                  _LibraryCard(
                    title: 'Favorites',
                    count: 5,
                    icon: Icons.favorite_border_rounded,
                    color: AppColors.deepCrimson,
                    onTap: () {},
                  ),
                  _LibraryCard(
                    title: 'Watched',
                    count: 48,
                    icon: Icons.check_circle_outline_rounded,
                    color: AppColors.tealCyan,
                    onTap: () {},
                  ),
                  _LibraryCard(
                    title: 'Downloads',
                    count: 0,
                    icon: Icons.download_for_offline_outlined,
                    color: AppColors.amberGold,
                    onTap: () {},
                  ),
                ]),
              ),
            ),
            sliverVerticalSpacing(32),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI CURATOR SYSTEM v1.0',
                      style: AppTextStyles.font10BoldCoolGray.copyWith(
                        letterSpacing: 2,
                        color: AppColors.neonBlue.withValues(alpha: 0.6),
                        fontFamily: 'monospace',
                      ),
                    ),
                    verticalSpacing(16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.onyxBlack.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: AppColors.neonBlue.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.memory_rounded, color: AppColors.neonBlue, size: 20.sp),
                              horizontalSpacing(8),
                              const Icon(Icons.auto_awesome_rounded, color: AppColors.neonBlue),
                              horizontalSpacing(8),
                              Icon(Icons.analytics_outlined, color: AppColors.neonBlue, size: 20.sp),
                            ],
                          ),
                          verticalSpacing(16),
                          Text(
                            'ANALYZING CINEMATIC PREFERENCES...',
                            style: AppTextStyles.font14PureWhiteManrope.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: AppColors.iceBlue,
                            ),
                          ),
                          verticalSpacing(12),
                          Text(
                            'System requires more data to generate smart collections. Keep exploring and adding to your Watchlist to unlock AI insights.',
                            style: AppTextStyles.font12CoolGrayManrope.copyWith(
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sliverVerticalSpacing(100),
          ],
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onyxBlack,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: color.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22.sp),
              ),
              const Spacer(),
              Text(
                '$count',
                style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                  fontSize: 20.sp,
                ),
              ),
              Text(
                title,
                style: AppTextStyles.font12CoolGrayManrope.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
