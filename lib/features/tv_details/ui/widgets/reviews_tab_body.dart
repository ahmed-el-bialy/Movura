import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/empty_section_message.dart';
import '../../logic/reviews/reviews_cubit.dart';
import '../../../../core/widgets/shared_details/reviews_list.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesReviewsCubit, TvSeriesReviewsState>(
      builder: (context, state) {
        if (state is TvReviewsLoaded) {
          if (state.response.isEmpty) {
            return const EmptySectionMessage(
              icon: Icons.reviews_outlined,
              title: "No reviews yet",
              subTitle: "Stay tuned for upcoming community feedback",
            );
          }
          return ReviewsList(reviews: state.response);
        } else if (state is TvReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TvReviewsError) {
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
