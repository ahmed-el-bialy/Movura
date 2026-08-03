import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';
import 'package:movura/core/widgets/shared_details/reviews_list.dart';

import '../../logic/reviews/reviews_cubit.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesReviewsCubit, TvSeriesReviewsState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is TvReviewsLoading,
          errorMessage: state is TvReviewsError ? state.errorMessage : null,
          onRetry: () {},
          isEmpty: state is TvReviewsLoaded && state.response.isEmpty,
          emptyIcon: Icons.reviews_outlined,
          emptyTitle: "No reviews yet",
          emptySubTitle: "Stay tuned for upcoming community feedback",
          child: state is TvReviewsLoaded
              ? ReviewsList(reviews: state.response)
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
