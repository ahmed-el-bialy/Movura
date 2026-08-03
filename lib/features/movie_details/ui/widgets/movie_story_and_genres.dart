import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/layout/read_more_text.dart';
import '../../../see_all/data/models/see_all_arguments.dart';
import '../../data/models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(vertical: AppSpacing.l, horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "STORYLINE",
            style: TextStyles.font13BoldNeonBlueSora.copyWith(
              letterSpacing: 1.5,
              fontWeight: Weights.black,
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.m),
          ReadMoreText(content: model.overview!),
          AppSpacing.verticalSpacing(14),
          if (model.genres!.isNotEmpty)
            SizedBox(
              height: 36.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: model.genres!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppSpacing.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.onyxBlack.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.pureWhite.withValues(alpha: 0.08),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(
                            RouteNames.seeAllScreen,
                            arguments: SeeAllArguments(
                              title: model.genres![index].name,
                              endpoint: SeeAllEndpoint.moviesByGenre,
                              id: model.genres![index].id,
                            ),
                          );
                        },
                        splashColor: AppColors.neonBlue.withValues(alpha: .2),
                        highlightColor: AppColors.neonBlue.withValues(
                          alpha: .1,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        child: Center(
                          child: Padding(
                            padding: AppSpacing.horizontal(14),
                            child: Text(
                              model.genres![index].name,
                              style: TextStyles.font12MediumPlatinumGray
                                  .copyWith(
                                    fontSize: 13.sp,
                                    color: AppColors.platinumGray,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
