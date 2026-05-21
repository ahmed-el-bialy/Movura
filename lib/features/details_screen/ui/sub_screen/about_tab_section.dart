import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/spacing.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/actor_card.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details_screen/ui/widgets/company_card.dart';

import '../../../../core/helper/number_formatter.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/main_details/about_cubit.dart';
import 'details_loading_skeleton.dart';

class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        if (state is AboutLoading) {
          return DetailsLoadingSkeleton();
        } else if (state is AboutSuccess) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Card(
                  color: AppColors.onyxBlack.withValues(alpha: .7),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "BUDGET",
                              style: Styles.font14platinumGraySimiBoldSora,
                            ),
                            Spacer(flex: 1),
                            Text(
                              state.model.budget.toFullCurrency(),
                              style: Styles.font13NeonCyanBoldSora,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppColors.slateGray.withValues(alpha: .5)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "REVENUE",
                              style: Styles.font14platinumGraySimiBoldSora,
                            ),
                            Spacer(flex: 1),
                            Text(
                              state.model.revenue.toFullCurrency(),
                              style: Styles.font13NeonCyanBoldSora,
                            ),
                          ],
                        ),
                      ),

                      Divider(color: AppColors.slateGray.withValues(alpha: .5)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "ADULT CONTENT",
                              style: Styles.font14platinumGraySimiBoldSora,
                            ),
                            Spacer(flex: 1),
                            Text(
                              "${state.model.adultContent}",
                              style: Styles.font13NeonCyanBoldSora,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpacing(15),
              SectionTitle(
                sectionName: "CAST",
                actionName: "View All >>",
                onTap: () {},
              ),
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.model.actors.movieActors.length,
                  itemBuilder: (context, index) {
                    return ActorCard(
                      actor: state.model.actors.movieActors[index],
                    );
                  },
                ),
              ),
              verticalSpacing(15),
              SectionTitle(sectionName: "Companies"),
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.model.companies.length,
                  itemBuilder: (context, index) {
                    return CompanyCard(company: state.model.companies[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state is AboutFailed) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(state.errorMessage, style: Styles.font11IGoldBold),
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There was An Error",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
