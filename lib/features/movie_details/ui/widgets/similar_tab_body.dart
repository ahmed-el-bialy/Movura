import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';
import 'package:movura/core/widgets/shared_details/similar_content_tab_body.dart';

import '../../logic/similar_content/similar_content_cubit.dart';

class MovieSimilarTabBody extends StatelessWidget {
  const MovieSimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarContentCubit, SimilarContentState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is SimilarContentLoading,
          errorMessage: state is SimilarContentError ? state.errorMessage : null,
          onRetry: () {},
          child: state is SimilarContentLoaded
              ? SimilarContentTabBody(
                  recommendList: state.similarMovieResponse.recommendations!.results!,
                  similarList: state.similarMovieResponse.similar!.results!,
                  mediaType: "movie",
                  mediaId: state.id,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
