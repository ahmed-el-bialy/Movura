import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/features/tv_details/logic/about_tv/about_tv_cubit.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_screen_body.dart';

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
            return const Center(child: CircularProgressIndicator(color: AppColors.neonBlue));
          } else if (state is AboutTvLoaded) {
            return TvScreenBody(model: state.model);
          } else if (state is AboutTvError) {
            return AppErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () {},
            );
          } else {
            return const AppErrorWidget(
              errorMessage: "There was An Error",
            );
          }
        },
      ),
    );
  }
}
