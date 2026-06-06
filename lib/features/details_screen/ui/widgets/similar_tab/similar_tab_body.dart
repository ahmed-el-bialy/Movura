import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/ui/widgets/similar_tab/similar_content_loaded_body.dart';

import '../../../logic/movie_screen_cubit/similar_content/similar_content_cubit.dart';

class SimilarTabBody extends StatelessWidget {
  const SimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarContentCubit, SimilarContentState>(
      builder: (context, state) {
        if (state is SimilarContentLoaded) {
          return SimilarContentLoadedBody(
            recommendList: state.similarMovieResponse.recommendations!.results!,
            similarList: state.similarMovieResponse.similar!.results!,
          );
        } else if (state is SimilarContentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SimilarContentFailed) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.errorMessage, style: Styles.font11BoldGold),
          );
        } else {
          return Text("There was an error", style: Styles.font13MediumNeonCyan);
        }
      },
    );
  }
}
