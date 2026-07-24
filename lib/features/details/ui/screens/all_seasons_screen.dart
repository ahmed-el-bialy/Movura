import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_icon_button.dart';
import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/core/widgets/back_to_home_scope.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/tv_season_card.dart';

class AllSeasonsScreen extends StatelessWidget {
  const AllSeasonsScreen({super.key, required this.arguments});

  final AllSeasonsArgumentsModel arguments;

  void _openSeason(BuildContext context, int seasonNumber, String seasonName) {
    context.pushNamed(
      RouteNames.seasonDetailsScreen,
      SeasonArgumentsModel(
        tvId: arguments.tvId,
        seasonNumber: seasonNumber,
        tvTitle: arguments.tvTitle,
        seasonName: seasonName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final seasons = arguments.seasons
        .where((season) => season.seasonNumber > 0)
        .toList();

    return BackToHomeScope(
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: AppColors.richEerieBlack.withValues(alpha: 0.8),
          elevation: 0,
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          title: Text(
            '${arguments.tvTitle} — Seasons',
            style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
              fontSize: 16.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: AppIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: () => context.popToHomeOrGoHome(),
            size: 20,
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.fromLTRB(12.r, 12.r, 12.r, 90.h),
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.72,
          ),
          itemCount: seasons.length,
          itemBuilder: (context, index) {
            final season = seasons[index];
            return TvSeasonCard(
              tvSeasonModel: season,
              onTap: () =>
                  _openSeason(context, season.seasonNumber, season.name),
            );
          },
        ),
        bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
      ),
    );
  }
}

