import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/app_colors.dart';

import '../../logic/movie_screen_cubit/main_details/about_cubit.dart';
import '../details_loading_skeleton.dart';
import '../widgets/movie_widgets/movie_screen_body.dart';

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
            return DetailsLoadingSkeleton();
          } else if (state is AboutSuccess) {
            return MovieScreenBody(model: state.model);
          } else if (state is AboutFailed) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text("There was An Error"));
          }
        },
      ),
    );
  }
}
