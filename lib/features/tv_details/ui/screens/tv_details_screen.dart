import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/movura_loading_indicator.dart';
import '../../logic/about_tv/about_tv_cubit.dart';
import '../widgets/tv_screen_body.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  const TvSeriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.richEerieBlack,
      body: BlocBuilder<AboutTvCubit, AboutTvState>(
        builder: (context, state) {
          if (state is AboutTvLoading) {
            return Center(child: MovuraLoadingIndicator());
          } else if (state is AboutTvLoaded) {
            return TvScreenBody(model: state.model);
          } else if (state is AboutTvError) {
            return AppErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () {},
            );
          } else {
            return const AppErrorWidget(errorMessage: "There was An Error");
          }
        },
      ),
    );
  }
}
