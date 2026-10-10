import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/core/widgets/shared_details/actors_list.dart';
import 'package:movura/core/widgets/shared_details/companies_list.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';
import 'package:movura/core/widgets/shared_details/images_list.dart';
import 'package:movura/core/widgets/shared_details/videos_list.dart';
import 'package:movura/features/tv_details/ui/widgets/seasons_list.dart';
import 'package:movura/features/tv_details/ui/widgets/single_season_episodes.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_networks_list.dart';

import '../../logic/about/about_tv_cubit.dart';

class AboutTvTabBody extends StatelessWidget {
  const AboutTvTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutTvCubit, AboutTvState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is AboutTvLoading,
          errorMessage: state is AboutTvError ? state.errorMessage : null,
          onRetry: () {},
          child: state is AboutTvLoaded
              ? Column(
                  children: [
                    if (state.model.seasons != null &&
                        state.model.seasons!.length > 1) ...[
                      SectionTitle(
                        sectionName: 'Seasons',
                        actionName: AppConstants.sectionAction,
                        onTap: () {
                          context.pushNamed(
                            RouteNames.allSeasonsScreen,
                            arguments: AllSeasonsArgumentsModel(
                              tvId: state.model.id,
                              tvTitle: state.model.title ?? 'TV Show',
                              seasons: state.model.seasons ?? [],
                            ),
                          );
                        },
                      ),
                      SeasonsList(
                        seasons: state.model.seasons ?? [],
                        tvId: state.model.id,
                        tvTitle: state.model.title ?? 'TV Show',
                      ),
                      AppSpacing.verticalSpacing(15),
                    ],
                    if (state.model.seasons != null &&
                        state.model.seasons!.length == 1) ...[
                      const SectionTitle(sectionName: 'Episodes'),
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      SingleSeasonEpisodes(
                        tvId: state.model.id,
                        tvTitle: state.model.title ?? 'TV Show',
                        seasonNumber:
                            state.model.seasons?.first.seasonNumber ?? 1,
                      ),
                      AppSpacing.verticalSpacing(15),
                    ],
                    (state.model.actors?.tvActors != null &&
                            state.model.actors!.tvActors!.isNotEmpty)
                        ? SectionTitle(
                            sectionName: 'CAST',
                            actionName: AppConstants.sectionAction,
                            onTap: () {},
                          )
                        : const SizedBox.shrink(),
                    if (state.model.actors?.tvActors != null)
                      ActorsList(actors: state.model.actors?.tvActors ?? []),
                    AppSpacing.verticalSpacing(15),
                    (state.model.companies != null &&
                            state.model.companies!.isNotEmpty)
                        ? const SectionTitle(sectionName: 'Companies')
                        : const SizedBox.shrink(),
                    if (state.model.companies != null)
                      CompaniesList(company: state.model.companies ?? []),
                    AppSpacing.verticalSpacing(15),
                    (state.model.networks != null &&
                            state.model.networks!.isNotEmpty)
                        ? const SectionTitle(sectionName: 'Networks')
                        : const SizedBox.shrink(),
                    if (state.model.networks != null)
                      TvNetworksList(network: state.model.networks ?? []),
                    AppSpacing.verticalSpacing(15),
                    state.model.mediaImages?.backdropImages != null &&
                            state.model.mediaImages!.backdropImages!.isNotEmpty
                        ? const SectionTitle(sectionName: 'IMAGES')
                        : const SizedBox.shrink(),
                    if (state.model.mediaImages?.backdropImages != null)
                      ImagesList(
                        images: state.model.mediaImages?.backdropImages ?? [],
                        height: 250,
                        imageFit: BoxFit.fill,
                      ),
                    AppSpacing.verticalSpacing(15),
                    state.model.mediaImages?.logoImages != null &&
                            state.model.mediaImages!.logoImages!.isNotEmpty
                        ? const SectionTitle(sectionName: 'LOGOS')
                        : const SizedBox.shrink(),
                    if (state.model.mediaImages?.logoImages != null)
                      ImagesList(
                        images: state.model.mediaImages?.logoImages ?? [],
                        imageFit: BoxFit.contain,
                        herPadding: 8,
                        imageWidth: 120,
                        height: 180,
                      ),
                    if (state.model.tvVideos?.videoList != null &&
                        state.model.tvVideos!.videoList!.isNotEmpty) ...[
                      AppSpacing.verticalSpacing(15),
                      const SectionTitle(sectionName: 'TRAILERS & CLIPS'),
                      AppSpacing.verticalSpacing(AppSpacing.s),
                      VideosList(allVideos: state.model.tvVideos!.videoList!),
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
