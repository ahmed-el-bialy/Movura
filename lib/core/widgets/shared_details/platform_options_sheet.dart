import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/watch_provider_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PlatformOptionsSheet extends StatelessWidget {
  const PlatformOptionsSheet({
    super.key,
    required this.homepageUrl,
    this.watchProviders,
  });

  final String homepageUrl;
  final WatchProviderResponse? watchProviders;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final providers =
        watchProviders?.results?['US'] ??
        watchProviders?.results?.values.firstOrNull;
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
            style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
              fontSize: 18.sp,
            ),
          ),
          verticalSpacing(8),
          Text(
            'Visit official sources to watch this content',
            style: TextStyles.font12CoolGrayManrope,
          ),
          verticalSpacing(24),
          if (streaming.isNotEmpty) ...[
            Text(
              'AVAILABLE ON',
              style: TextStyles.font10BoldCoolGray.copyWith(
                letterSpacing: 1.2,
                color: AppColors.neonBlue,
              ),
            ),
            verticalSpacing(16),
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: streaming.map((provider) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${provider.logoPath}',
                        width: 45.r,
                        height: 45.r,
                        errorWidget: (_, _, _) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    verticalSpacing(4),
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        provider.providerName,
                        style: TextStyle(fontSize: 8.sp, color: Colors.white70),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            verticalSpacing(32),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionItem(
                icon: Icons.public_rounded,
                label: 'Website',
                onTap: () {
                  if (homepageUrl.isNotEmpty) {
                    _launchUrl(homepageUrl);
                  }
                  Navigator.pop(context);
                },
                color: AppColors.neonBlue,
              ),
              _ActionItem(
                icon: Icons.copy_rounded,
                label: 'Copy Link',
                onTap: () {
                  if (homepageUrl.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text: homepageUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied to clipboard')),
                    );
                  }
                  Navigator.pop(context);
                },
                color: AppColors.tealCyan,
              ),
              _ActionItem(
                icon: Icons.share_rounded,
                label: 'Share',
                onTap: () {
                  if (homepageUrl.isNotEmpty) {
                    Share.share(homepageUrl);
                  }
                  Navigator.pop(context);
                },
                color: AppColors.amberGold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
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
    return Column(
      children: [
        Material(
          color: AppColors.onyxBlack,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            splashColor: color.withValues(alpha: 0.2),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
          ),
        ),
        verticalSpacing(8),
        Text(
          label,
          style: TextStyles.font10BoldCoolGray.copyWith(
            color: Colors.white70,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
