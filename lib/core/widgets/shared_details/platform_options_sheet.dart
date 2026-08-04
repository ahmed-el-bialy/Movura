import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/models/watch_provider_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
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


  @override
  Widget build(BuildContext context) {
    final egProviders = watchProviders?.results?['EG'];
    final usProviders = watchProviders?.results?['US'];
    final gbProviders = watchProviders?.results?['GB'];

    return Container(
      padding: AppSpacing.only(
        left: AppSpacing.xl,
        top: AppSpacing.m,
        right: AppSpacing.xl,
        bottom: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: AppColors.charcoalBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        border: Border.all(
          color: AppColors.pureWhite.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.slateGray.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Watch Options',
                      style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                        fontSize: 22.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                    AppSpacing.verticalSpacing(AppSpacing.xs),
                    Text(
                      'Choose your preferred platform or region',
                      style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                        color: AppColors.coolGray.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              _TopActionIcon(
                icon: Icons.share_rounded,
                onTap: () {
                  if (homepageUrl.isNotEmpty) Share.share(homepageUrl);
                },
                color: AppColors.amberGold,
              ),
              AppSpacing.horizontalSpacing(AppSpacing.m),
              _TopActionIcon(
                icon: Icons.close_rounded,
                onPressed: () => Navigator.pop(context),
                color: AppColors.coolGray,
              ),
            ],
          ),
          AppSpacing.verticalSpacing(AppSpacing.xxl),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (egProviders != null)
                    _ProviderRegionSection(
                      regionName: 'EGYPT',
                      providers: egProviders.flatrate ?? [],
                      link: egProviders.link,
                    ),
                  if (usProviders != null)
                    _ProviderRegionSection(
                      regionName: 'UNITED STATES',
                      providers: usProviders.flatrate ?? [],
                      link: usProviders.link,
                    ),
                  if (gbProviders != null)
                    _ProviderRegionSection(
                      regionName: 'UNITED KINGDOM',
                      providers: gbProviders.flatrate ?? [],
                      link: gbProviders.link,
                    ),
                  if (homepageUrl.isNotEmpty) ...[
                    AppSpacing.verticalSpacing(AppSpacing.xl),
                    Text(
                      'OFFICIAL WEBSITE',
                      style: TextStyles.font10BoldCoolGray.copyWith(
                        letterSpacing: 1.5,
                        color: AppColors.neonBlue.withValues(alpha: 0.7),
                      ),
                    ),
                    AppSpacing.verticalSpacing(AppSpacing.m),
                    _WebsiteTile(url: homepageUrl),
                  ],
                ],
              ),
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.xl),
        ],
      ),
    );
  }
}

class _TopActionIcon extends StatelessWidget {
  const _TopActionIcon({
    required this.icon,
    this.onTap,
    this.onPressed,
    required this.color,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: AppSpacing.all(10),
        decoration: BoxDecoration(
          color: AppColors.onyxBlack.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
    );
  }
}

class _ProviderRegionSection extends StatelessWidget {
  const _ProviderRegionSection({
    required this.regionName,
    required this.providers,
    this.link,
  });

  final String regionName;
  final List<WatchProvider> providers;
  final String? link;

  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          regionName,
          style: TextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 1.5,
            color: AppColors.neonBlue.withValues(alpha: 0.7),
          ),
        ),
        AppSpacing.verticalSpacing(AppSpacing.m),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: providers.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final provider = providers[index];
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: InkWell(
                  onTap: () {
                    if (link != null) {
                      _launchUrl(link!);
                    }
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${provider.logoPath}',
                          width: 50.r,
                          height: 50.r,
                          errorWidget: (_, _, _) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.xs),
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          provider.providerName,
                          style: TextStyles.font10MediumCoolGraySora.copyWith(
                            fontSize: 9.sp,
                            color: AppColors.pureWhite.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        AppSpacing.verticalSpacing(AppSpacing.l),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}

class _WebsiteTile extends StatelessWidget {
  const _WebsiteTile({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint('Could not launch $url');
        }
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: AppSpacing.all(16),
        decoration: BoxDecoration(
          color: AppColors.neonBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.public_rounded, color: AppColors.neonBlue),
            AppSpacing.horizontalSpacing(AppSpacing.l),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Official Website',
                    style: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                  Text(
                    url,
                    style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                      color: AppColors.neonBlue.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.neonBlue,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
