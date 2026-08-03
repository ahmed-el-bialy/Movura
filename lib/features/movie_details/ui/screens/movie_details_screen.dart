

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../logic/main_details/about_cubit.dart';
import '../widgets/movie_screen_body.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.richEerieBlack,
      body: BlocBuilder<AboutCubit, AboutState>(
        builder: (context, state) {
          if (state is AboutLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.neonBlue));
          } else if (state is AboutLoaded) {
            return MovieScreenBody(model: state.model);
          } else if (state is AboutError) {
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
