import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/widgets/section_title.dart';

import '../../../../../core/models/video_model.dart';
import '../../../logic/movie_screen_cubit/main_details/about_cubit.dart';
import '../../details_loading_skeleton.dart';
import '../shared_widgets/actors_list.dart';
import '../shared_widgets/companies_list.dart';
import '../shared_widgets/images_list.dart';
import '../shared_widgets/videos_list.dart';

class AboutTabBody extends StatelessWidget {
  const AboutTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        if (state is AboutLoading) {
          return const DetailsLoadingSkeleton();
        } else if (state is AboutSuccess) {
          final List<VideoModel> allVideos =
              state.model.movieVideos?.videoList ?? [];
          return Column(
            children: [
              (state.model.actors.movieActors.isNotEmpty)
                  ? SectionTitle(
                      sectionName: "CAST",
                      actionName: "View All >>",
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),

              ActorsList(actors: state.model.actors.movieActors),
              verticalSpacing(15),

              (state.model.companies.isNotEmpty)
                  ? const SectionTitle(sectionName: "Companies")
                  : const SizedBox.shrink(),
              CompaniesList(company: state.model.companies),
              verticalSpacing(15),

              state.model.mediaImages.backdropImages.isNotEmpty
                  ? const SectionTitle(sectionName: "IMAGES")
                  : const SizedBox.shrink(),
              ImagesList(
                images: state.model.mediaImages.backdropImages,
                height: 250,
                imageFit: BoxFit.fill,
              ),
              verticalSpacing(15),

              state.model.mediaImages.logoImages.isNotEmpty
                  ? const SectionTitle(sectionName: "LOGOS")
                  : const SizedBox.shrink(),
              ImagesList(
                images: state.model.mediaImages.logoImages,
                imageFit: BoxFit.contain,
                herPadding: 8,
                imageWidth: 120,
                height: 180,
              ),

              if (allVideos.isNotEmpty) ...[
                verticalSpacing(15),
                const SectionTitle(sectionName: "TRAILERS & CLIPS"),
                verticalSpacing(8),
                VideosList(allVideos: allVideos),
              ],
            ],
          );
        } else if (state is AboutFailed) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(state.errorMessage, style: AppTextStyles.font11BoldGold),
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
