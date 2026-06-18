import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/similar_content_tab_body.dart';

import '../../../logic/tv_series_cubit/similar_content/similar_content_cubit.dart';

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
          return SimilarContentTabBody(
            mediaType: "tv",
            recommendList:
                state.similarContentResponse.recommendations!.results!,
            similarList: state.similarContentResponse.similar!.results!,
          );
        } else if (state is TvSimilarContentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TvSimilarContentFailed) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.errorMessage, style: AppTextStyles.font11BoldGold),
          );
        } else {
          return Text("There was an error", style: AppTextStyles.font13MediumNeonBlue);
        }
      },
    );
  }
}
