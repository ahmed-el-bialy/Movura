import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/shared_details/actors_list.dart';
import '../../../../core/widgets/shared_details/companies_list.dart';
import '../../../../core/widgets/shared_details/images_list.dart';
import '../../../../core/widgets/shared_details/videos_list.dart';
import '../../logic/main_details/about_cubit.dart';

class AboutTabBody extends StatelessWidget {
  const AboutTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        if (state is AboutLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.neonBlue),
          );
        } else if (state is AboutLoaded) {
          final videos = state.model.movieVideos?.videoList ?? [];
          return Column(
            children: [
              if (state.model.actors?.movieActors != null &&
                  state.model.actors!.movieActors!.isNotEmpty) ...[
                const SectionTitle(
                  sectionName: "CAST",
                  actionName: AppConstants.sectionAction,
                ),
                ActorsList(actors: state.model.actors?.movieActors ?? []),
                verticalSpacing(15),
              ],
              if (state.model.companies != null &&
                  state.model.companies!.isNotEmpty) ...[
                const SectionTitle(sectionName: "Companies"),
                CompaniesList(company: state.model.companies ?? []),
                verticalSpacing(15),
              ],
              if (state.model.mediaImages?.backdropImages != null &&
                  state.model.mediaImages!.backdropImages!.isNotEmpty) ...[
                const SectionTitle(sectionName: "IMAGES"),
                ImagesList(
                  images: state.model.mediaImages?.backdropImages ?? [],
                  height: 250,
                  imageFit: BoxFit.fill,
                ),
                verticalSpacing(15),
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
              if (videos.isNotEmpty) ...[
                verticalSpacing(15),
                const SectionTitle(sectionName: "TRAILERS & CLIPS"),
                verticalSpacing(8),
                VideosList(allVideos: videos),
                verticalSpacing(35),
              ],
            ],
          );
        } else if (state is AboutError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {},
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
