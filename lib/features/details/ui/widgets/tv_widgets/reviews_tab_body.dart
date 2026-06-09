import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/empty_section_message.dart';

import '../../../logic/tv_series_cubit/reviews/reviews_cubit.dart';
import '../shared_widgets/reviews_list.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesReviewsCubit, TvSeriesReviewsState>(
      builder: (context, state) {
        if (state is TvReviewsLoaded) {
          if (state.response.isEmpty) {
            return EmptySectionMessage(
              icon: Icons.reviews_outlined,
              title: "No reviews yet",
              subTitle: "Stay tuned for upcoming community feedback",
            );
          }
          return ReviewsList(reviews: state.response,);
        } else if (state is TvReviewsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TvReviewsFailed) {
          return Center(
            child: Text(state.errorMessage, style: Styles.font11BoldGold),
          );
        } else {
          return Text(
            " there was an error",
            style: Styles.font13MediumNeonCyan,
          );
        }
      },
    );
  }
}
