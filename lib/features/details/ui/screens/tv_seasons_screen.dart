import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/arguments_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/features/details/data/repos/tv_series_repo.dart';
import 'package:movura/features/details/logic/tv_series_cubit/tv_seasons_cubit/tv_seasons_cubit.dart';
import 'package:movura/features/details/ui/screens/tv_seasons/tv_season_details_body.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/season_loading_skeleton.dart';

import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/core/widgets/back_to_home_scope.dart';

class TvSeasonDetailsScreen extends StatelessWidget {
  const TvSeasonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SeasonArgumentsModel;

    return BlocProvider(
      create: (context) => sl<TvSeasonsCubit>()
        ..getTvSeasonDetails(
          tvId: args.tvId,
          seasonNumber: args.seasonNumber,
        ),
      child: BackToHomeScope(
        child: Scaffold(
          backgroundColor: AppColors.richEerieBlack,
          extendBody: true,
          body: BlocBuilder<TvSeasonsCubit, TvSeasonsState>(
            builder: (context, state) {
              if (state is TvSeasonsLoading) {
                return SeasonLoadingSkeleton(
                  tvTitle: args.tvTitle,
                  seasonName: args.seasonName,
                );
              } else if (state is TvSeasonsLoaded) {
                return TvSeasonDetailsBody(
                  seasonDetails: state.seasonDetails,
                  tvTitle: args.tvTitle,
                  tvId: args.tvId,
                );
              } else if (state is TvSeasonsFailed) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: AppColors.softRed),
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
