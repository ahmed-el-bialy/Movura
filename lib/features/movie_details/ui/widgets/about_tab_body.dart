import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';

import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/core/widgets/shared_details/actors_list.dart';
import 'package:movura/core/widgets/shared_details/companies_list.dart';
import 'package:movura/core/widgets/shared_details/images_list.dart';
import 'package:movura/core/widgets/shared_details/videos_list.dart';
import '../../logic/about/about_cubit.dart';

class AboutTabBody extends StatelessWidget {
  const AboutTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is AboutLoading,
          errorMessage: state is AboutError ? state.errorMessage : null,
          onRetry: () {},
          child: state is AboutLoaded
              ? Column(
                  children: [
                    if (state.model.actors?.movieActors != null &&
                        state.model.actors!.movieActors!.isNotEmpty) ...[
                      const SectionTitle(
                        sectionName: "CAST",
                        actionName: AppConstants.sectionAction,
                      ),
                      ActorsList(actors: state.model.actors?.movieActors ?? []),
                      AppSpacing.verticalSpacing(15),
                    ],
                    if (state.model.companies != null &&
                        state.model.companies!.isNotEmpty) ...[
                      const SectionTitle(sectionName: "Companies"),
                      CompaniesList(company: state.model.companies ?? []),
                      AppSpacing.verticalSpacing(15),
                    ],
                    if (state.model.mediaImages?.backdropImages != null &&
                        state
                            .model
                            .mediaImages!
                            .backdropImages!
                            .isNotEmpty) ...[
                      const SectionTitle(sectionName: "IMAGES"),
                      ImagesList(
                        images: state.model.mediaImages?.backdropImages ?? [],
                        height: 250,
                        imageFit: BoxFit.fill,
                      ),
                      AppSpacing.verticalSpacing(15),
                    ],
                    if (state.model.mediaImages?.logoImages != null &&
                        state.model.mediaImages!.logoImages!.isNotEmpty) ...[
                      const SectionTitle(sectionName: "LOGOS"),
                      ImagesList(
                        images: state.model.mediaImages?.logoImages ?? [],
                        imageFit: BoxFit.contain,
                        herPadding: 8,
                        imageWidth: 120,
                        height: 180,
                      ),
                    ],
                    if (state.model.movieVideos?.videoList != null &&
                        state.model.movieVideos!.videoList!.isNotEmpty) ...[
                      AppSpacing.verticalSpacing(15),
                      const SectionTitle(sectionName: "TRAILERS & CLIPS"),
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      VideosList(
                        allVideos: state.model.movieVideos!.videoList!,
                      ),
                      AppSpacing.verticalSpacing(35),
                    ],
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
