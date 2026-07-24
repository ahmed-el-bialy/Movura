import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/core/widgets/back_to_home_scope.dart';
import 'package:movura/features/details/data/repos/tv_series_repo.dart';
import 'package:movura/features/details/logic/tv_series_cubit/tv_episode_details_cubit/tv_episode_details_cubit.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/episode_loading_skeleton.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/episode_widgets/episode_details_body.dart';

class EpisodeDetailsScreen extends StatelessWidget {
  const EpisodeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EpisodeArgumentsModel;

    return BlocProvider(
      create: (context) =>
          sl<TvEpisodeDetailsCubit>()..getTvEpisodeDetails(
            tvId: args.tvId,
            seasonNumber: args.seasonNumber,
            episodeNumber: args.episodeNumber,
          ),
      child: BackToHomeScope(
        child: Scaffold(
          backgroundColor: AppColors.richEerieBlack,
          extendBody: true,
          body: BlocBuilder<TvEpisodeDetailsCubit, TvEpisodeDetailsState>(
            builder: (context, state) {
              if (state is TvEpisodeDetailsLoading) {
                return const EpisodeLoadingSkeleton();
              }

              if (state is TvEpisodeDetailsLoaded) {
                return EpisodeDetailsBody(
                  episode: state.episodeDetails,
                  tvTitle: args.tvTitle,
                  seasonName: args.seasonName,
                  tvId: args.tvId,
                  totalEpisodes: args.totalEpisodes,
                );
              }

              if (state is TvEpisodeDetailsFailed) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Text(
                      state.errorMessage,
                      style: AppTextStyles.font13MediumNeonBlue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
        ),
      ),
    );
  }
}
