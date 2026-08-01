import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/shared_details/similar_content_tab_body.dart';
import 'package:movura/features/tv_details/logic/similar_content/similar_content_cubit.dart';

class SimilarTabBody extends StatelessWidget {
  const SimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesSimilarContentCubit, TvSeriesSimilarContentState>(
      builder: (context, state) {
        if (state is TvSimilarContentLoaded) {
          return SimilarContentTabBody(
            mediaType: "tv",
            recommendList: state.similarContentResponse.recommendations?.results ?? [],
            similarList: state.similarContentResponse.similar?.results ?? [],
          );
        } else if (state is TvSimilarContentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TvSimilarContentError) {
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
