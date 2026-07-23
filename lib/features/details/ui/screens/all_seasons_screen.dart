import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
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

    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      appBar: AppBar(
        title: Text(
          '${arguments.tvTitle} — Seasons',
          style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
            fontSize: 15.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(12.r),
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
            onTap: () => _openSeason(context, season.seasonNumber, season.name),
          );
        },
      ),
    );
  }
}
