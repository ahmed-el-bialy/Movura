import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/tv_season_card.dart';

class SeasonsList extends StatelessWidget {
  const SeasonsList({
    super.key,
    required this.seasons,
    required this.tvId,
    required this.tvTitle,
  });

  final List<TvSeasonModel> seasons;
  final int tvId;
  final String tvTitle;

  void _openSeason(BuildContext context, TvSeasonModel season) {
    if (season.seasonNumber <= 0) return;

    context.pushNamed(
      RouteNames.seasonDetailsScreen,
      SeasonArgumentsModel(
        tvId: tvId,
        seasonNumber: season.seasonNumber,
        tvTitle: tvTitle,
        seasonName: season.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displaySeasons =
        seasons.where((season) => season.seasonNumber > 0).toList();

    if (displaySeasons.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 280.h,
        child: ListView.builder(
          itemExtent: 210.w,
          scrollDirection: Axis.horizontal,
          itemCount: displaySeasons.length,
          itemBuilder: (context, index) {
            final season = displaySeasons[index];
            return Padding(
              padding: EdgeInsets.all(8.0).r,
              child: TvSeasonCard(
                tvSeasonModel: season,
                onTap: () => _openSeason(context, season),
              ),
            );
          },
        ),
      ),
    );
  }
}
