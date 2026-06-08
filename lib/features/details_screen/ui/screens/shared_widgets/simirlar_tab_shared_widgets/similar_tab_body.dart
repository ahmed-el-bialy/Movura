import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/ui/screens/shared_widgets/simirlar_tab_shared_widgets/similar_content_loaded_body.dart';

import '../../../../logic/tv_series_cubit/similar_content/similar_content_cubit.dart';

class SimilarTabBody extends StatelessWidget {
  const SimilarTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TvSeriesSimilarContentCubit,
      TvSeriesSimilarContentState
    >(
      builder: (context, state) {
        if (state is TvSimilarContentLoaded) {
          return SimilarContentLoadedBody(
            recommendList:
                state.similarContentResponse.recommendations!.results!,
            similarList: state.similarContentResponse.similar!.results!,
          );
        } else if (state is TvSimilarContentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TvSimilarContentFailed) {
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
