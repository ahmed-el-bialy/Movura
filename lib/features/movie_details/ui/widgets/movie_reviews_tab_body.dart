import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/shared_details/details_tab_state_wrapper.dart';
import 'package:movura/core/widgets/shared_details/reviews_list.dart';

import '../../logic/reviews/reviews_cubit.dart';

class MovieReviewsTabBody extends StatelessWidget {
  const MovieReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        return DetailsTabStateWrapper(
          isLoading: state is ReviewsLoading,
          errorMessage: state is ReviewsError ? state.errorMessage : null,
          onRetry: () => context.read<ReviewsCubit>().getMovieReviews(
            id: (state as dynamic).id, // Fallback if needed, but usually onRetry is handled by Cubit refresh
          ),
          isEmpty: state is ReviewsLoaded && state.response.isEmpty,
          emptyIcon: Icons.reviews_outlined,
          emptyTitle: "No reviews yet",
          emptySubTitle: "Stay tuned for upcoming community feedback",
          child: state is ReviewsLoaded
              ? ReviewsList(reviews: state.response)
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
