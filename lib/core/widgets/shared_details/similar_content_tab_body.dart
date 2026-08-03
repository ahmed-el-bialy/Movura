import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/see_all/data/models/see_all_arguments.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';


class SimilarContentTabBody extends StatelessWidget {
  const SimilarContentTabBody({
    super.key,
    required this.recommendList,
    required this.similarList,
    required this.mediaType,
    required this.mediaId,
  });

  final String mediaType;
  final int mediaId;
  final List<PosterModel> recommendList;
  final List<PosterModel> similarList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalSpacing(10),
        recommendList.isNotEmpty
            ? SectionTitle(
                sectionName: "RECOMMENDATIONS",
                actionName: AppConstants.sectionAction,
              )
            : const SizedBox.shrink(),
        AppSpacing.verticalSpacing(10),
        recommendList.isNotEmpty
            ? SizedBox(
                height: 250.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendList.length,
                  itemExtent: 180.w,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: AppSpacing.all(10),
                      child: PosterCard(
                        mediaModel: recommendList[index],
                        elevation: 2,
                        shadowColor: AppColors.coolGray,
                        mediaType: mediaType,
                      ),
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
        AppSpacing.verticalSpacing(10),
        similarList.isNotEmpty
            ? SectionTitle(
                sectionName: "SIMILAR",
                actionName: AppConstants.sectionAction,
                onTap: () {
                  final endpoint = mediaType == 'movie'
                      ? SeeAllEndpoint.similarMovies
                      : SeeAllEndpoint.similarTv;
                  context.pushNamed(
                    RouteNames.seeAllScreen,
                    arguments: SeeAllArguments(
                      title: "Similar",
                      endpoint: endpoint,
                      id: mediaId,
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
        AppSpacing.verticalSpacing(10),
        similarList.isNotEmpty
            ? SizedBox(
                height: 250.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: similarList.length,
                  itemExtent: 180.h,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: AppSpacing.all(AppSpacing.s),
                      child: PosterCard(
                        mediaModel: similarList[index],
                        elevation: 2,
                        shadowColor: AppColors.coolGray,
                        mediaType: mediaType,
                      ),
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
        AppSpacing.verticalSpacing(20),
      ],
    );
  }
}
