import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/seasons_list.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/tv_networks_list.dart';

import '../../../../../core/models/video_model.dart';
import '../shared_widgets/actors_list.dart';
import '../shared_widgets/companies_list.dart';
import '../shared_widgets/images_list.dart';
import '../shared_widgets/videos_list.dart';
import '../../details_loading_skeleton.dart';

class AboutTvTabBody extends StatelessWidget {
  const AboutTvTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutTvCubit, AboutTvState>(
      builder: (context, state) {
        if (state is AboutTvLoading) {
          return const DetailsLoadingSkeleton();
        } else if (state is AboutTvLoaded) {
          final List<VideoModel> allVideos =
              state.model.tvVideos?.videoList ?? [];
          return Column(
            children: [
              (state.model.seasons.isNotEmpty && state.model.seasons.length > 1)
                  ? SectionTitle(
                      sectionName: "Seasons",
                      actionName: "View All >>",
                      onTap: () {
                        context.pushNamed(
                          RouteNames.allSeasonsScreen,
                          AllSeasonsArgumentsModel(
                            tvId: state.model.id,
                            tvTitle: state.model.title,
                            seasons: state.model.seasons,
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),

              (state.model.seasons.isNotEmpty && state.model.seasons.length > 1)
                  ? SeasonsList(
                      seasons: state.model.seasons,
                      tvId: state.model.id,
                      tvTitle: state.model.title,
                    )
                  : const SizedBox.shrink(),

              (state.model.seasons.isNotEmpty && state.model.seasons.length > 1)
                  ? verticalSpacing(15)
                  : const SizedBox.shrink(),
              (state.model.actors.tvActors.isNotEmpty)
                  ? SectionTitle(
                      sectionName: "CAST",
                      actionName: "View All >>",
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),

              ActorsList(actors: state.model.actors.tvActors),
              verticalSpacing(15),

              (state.model.companies.isNotEmpty)
                  ? const SectionTitle(sectionName: "Companies")
                  : const SizedBox.shrink(),
              CompaniesList(company: state.model.companies),
              verticalSpacing(15),
              (state.model.networks.isNotEmpty)
                  ? const SectionTitle(sectionName: "Networks")
                  : const SizedBox.shrink(),
              TvNetworksList(network: state.model.networks),
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
                verticalSpacing(35),
              ],
            ],
          );
        } else if (state is AboutTvFailed) {
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
