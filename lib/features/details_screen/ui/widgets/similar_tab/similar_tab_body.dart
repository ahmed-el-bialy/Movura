import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/utils/helpers/spacing.dart';
import 'package:movura/core/widgets/poster_card.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details_screen/logic/similar_content/similar_content_cubit.dart';

class SimilarTabBody extends StatelessWidget {
  const SimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarContentCubit, SimilarContentState>(
      builder: (context, state) {
        if (state is SimilarContentLoaded) {
          return Column(
            children: [
              verticalSpacing(10),
              SectionTitle(
                sectionName: "RECOMMENDATIONS",
                actionName: "VIEW ALL",
              ),
              verticalSpacing(10),
              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state
                      .similarMovieResponse
                      .recommendations!
                      .results
                      ?.length,
                  itemExtent: 180.h,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PosterCard(
                        mediaModel: state
                            .similarMovieResponse
                            .recommendations!
                            .results?[index],
                        elevation: 2,
                        shadowColor: AppColors.coolGray,
                      ),
                    );
                  },
                ),
              ),
              verticalSpacing(10),
              SectionTitle(sectionName: "SIMILAR", actionName: "VIEW ALL"),
              verticalSpacing(10),
              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      state.similarMovieResponse.similar!.results?.length,
                  itemExtent: 180.h,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PosterCard(
                        mediaModel:
                            state.similarMovieResponse.similar!.results?[index],
                        elevation: 2,
                        shadowColor: AppColors.coolGray,
                      ),
                    );
                  },
                ),
              ),
              verticalSpacing(20),
            ],
          );
        } else if (state is SimilarContentLoading) {
          return CircularProgressIndicator();
        } else if (state is SimilarContentFailed) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.errorMessage, style: Styles.font11BoldGold),
          );
        } else {
          return Text("There was an error", style: Styles.font13MediumNeonCyan);
        }
      },
    );
  }
}
