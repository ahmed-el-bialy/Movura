import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/shared_details/similar_content_tab_body.dart';
import 'package:movura/features/movie_details/logic/similar_content/similar_content_cubit.dart';

class MovieSimilarTabBody extends StatelessWidget {
  const MovieSimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarContentCubit, SimilarContentState>(
      builder: (context, state) {
        if (state is SimilarContentLoaded) {
          return SimilarContentTabBody(
            recommendList: state.similarMovieResponse.recommendations!.results!,
            similarList: state.similarMovieResponse.similar!.results!,
            mediaType: "movie",
          );
        } else if (state is SimilarContentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SimilarContentError) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {},
          );
        } else {
          return const AppErrorWidget(errorMessage: "Something went wrong");
        }
      },
    );
  }
}
