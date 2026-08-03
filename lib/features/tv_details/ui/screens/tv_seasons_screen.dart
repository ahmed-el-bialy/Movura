import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/di.dart';
import '../../../../core/routing/arguments_models.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/navigation/app_navigation_bar.dart';
import '../../../../core/widgets/shared_details/season_loading_skeleton.dart';
import '../../logic/seasons/tv_seasons_cubit.dart';
import '../widgets/season_widgets/tv_season_details_body.dart';

class TvSeasonDetailsScreen extends StatelessWidget {
  const TvSeasonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SeasonArgumentsModel;

    return BlocProvider(
      create: (context) => sl<TvSeasonsCubit>()
        ..getTvSeasonDetails(tvId: args.tvId, seasonNumber: args.seasonNumber),
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
            } else if (state is TvSeasonsError) {
              return AppErrorWidget(
                errorMessage: state.errorMessage,
                onRetry: () =>
                    context.read<TvSeasonsCubit>().getTvSeasonDetails(
                      tvId: args.tvId,
                      seasonNumber: args.seasonNumber,
                    ),
              );
            }
            return const AppErrorWidget(errorMessage: "Something went wrong");
          },
        ),
        bottomNavigationBar: const AppNavigationBar(activeIndex: 0),
      ),
    );
  }
}
