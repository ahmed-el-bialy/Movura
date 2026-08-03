import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';
import 'package:movura/core/widgets/shared_details/similar_content_tab_body.dart';

import '../../logic/similar_content/similar_content_cubit.dart';

class SimilarTabBody extends StatelessWidget {
  const SimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesSimilarContentCubit, TvSeriesSimilarContentState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is TvSimilarContentLoading,
          errorMessage: state is TvSimilarContentError ? state.errorMessage : null,
          onRetry: () {},
          child: state is TvSimilarContentLoaded
              ? SimilarContentTabBody(
                  mediaType: "tv",
                  recommendList: state.similarContentResponse.recommendations?.results ?? [],
                  similarList: state.similarContentResponse.similar?.results ?? [],
                  mediaId: state.id,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
