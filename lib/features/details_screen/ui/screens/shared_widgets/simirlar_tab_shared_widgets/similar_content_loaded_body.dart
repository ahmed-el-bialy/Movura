import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/models/poster_model.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/utils/helpers/spacing.dart';
import '../../../../../../core/widgets/poster_card.dart';
import '../../../../../../core/widgets/section_title.dart';

class SimilarContentLoadedBody extends StatelessWidget {
  const SimilarContentLoadedBody({
    super.key,
    required this.recommendList,
    required this.similarList,
  });

  final List<PosterModel> recommendList;
  final List<PosterModel> similarList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacing(10),
        recommendList.isNotEmpty
            ? SectionTitle(
            sectionName: "RECOMMENDATIONS", actionName: "VIEW ALL")
            : Container(),
        verticalSpacing(10),
        recommendList.isNotEmpty
            ? SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendList.length,
            itemExtent: 180.h,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PosterCard(
                  mediaModel: recommendList[index],
                  elevation: 2,
                  shadowColor: AppColors.coolGray,
                ),
              );
            },
          ),
        ) : SizedBox(),
        verticalSpacing(10),
        similarList.isNotEmpty ? SectionTitle(
            sectionName: "SIMILAR", actionName: "VIEW ALL") : Container(),
        verticalSpacing(10),
        similarList.isNotEmpty ?SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarList.length,
            itemExtent: 180.h,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PosterCard(
                  mediaModel: similarList[index],
                  elevation: 2,
                  shadowColor: AppColors.coolGray,
                ),
              );
            },
          ),
        ): Container(),
        verticalSpacing(20),
      ],
    );
  }
}
