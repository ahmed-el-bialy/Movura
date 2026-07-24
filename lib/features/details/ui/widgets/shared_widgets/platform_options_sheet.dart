import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/watch_provider_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class PlatformOptionsSheet extends StatelessWidget {
  const PlatformOptionsSheet({
    super.key,
    required this.homepageUrl,
    this.watchProviders,
  });

  final String homepageUrl;
  final WatchProviderResponse? watchProviders;

  @override
  Widget build(BuildContext context) {
    // Extracting providers for a specific country (e.g., US) or just the first available
    final providers = watchProviders?.results?['US'] ?? watchProviders?.results?.values.firstOrNull;
    final streaming = providers?.flatrate ?? [];

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.charcoalBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.slateGray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          verticalSpacing(24),
          Text(
            'Streaming Options',
            style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
              fontSize: 18.sp,
            ),
          ),
          verticalSpacing(8),
          Text(
            'Visit official sources to watch this content',
            style: AppTextStyles.font12CoolGrayManrope,
          ),
          verticalSpacing(24),
          if (streaming.isNotEmpty) ...[
            Text(
              'AVAILABLE ON',
              style: AppTextStyles.font10BoldCoolGray.copyWith(
                letterSpacing: 1.2,
                color: AppColors.neonBlue,
              ),
            ),
            verticalSpacing(12),
            SizedBox(
              height: 60.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: streaming.length,
                separatorBuilder: (_, __) => horizontalSpacing(16),
                itemBuilder: (context, index) {
                  final provider = streaming[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl: '${ApiConstants.imageBaseUrl}${provider.logoPath}',
                          width: 40.r,
                          height: 40.r,
                          errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            verticalSpacing(24),
          ],
          _OptionTile(
            icon: Icons.public_rounded,
            label: 'Visit Official Website',
            onTap: () {
              // TODO: Implement url_launcher: launchUrl(Uri.parse(homepageUrl));
              Navigator.pop(context);
            },
            color: AppColors.neonBlue,
          ),
          verticalSpacing(12),
          _OptionTile(
            icon: Icons.share_rounded,
            label: 'Share Content Link',
            onTap: () {
              // TODO: Implement share functionality
              Navigator.pop(context);
            },
            color: AppColors.tealCyan,
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onyxBlack,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: color.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24.sp),
              horizontalSpacing(16),
              Text(
                label,
                style: AppTextStyles.font14PureWhiteManrope.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.coolGray,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
