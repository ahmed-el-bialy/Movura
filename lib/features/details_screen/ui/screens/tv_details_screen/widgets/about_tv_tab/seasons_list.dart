import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/tv_models/about_tv_series_model.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/about_tv_tab/tv_season_card.dart';

class SeasonsList extends StatelessWidget {
  const SeasonsList({super.key, required this.season});

  final List<TvSeasonModel> season;

  @override
  Widget build(BuildContext context) {
    if (season.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 280.h,
        child: ListView.builder(
          itemExtent: 210.w,
          scrollDirection: Axis.horizontal,
          itemCount: season.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.all(8.0).r,
              child: TvSeasonCard(tvSeasonModel: season[index]),
            );
          },
        ),
      ),
    );
  }
}
