

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/empty_section_message.dart';
import '../../../../core/widgets/shared_details/reviews_list.dart';
import '../../logic/reviews/reviews_cubit.dart';

class MovieReviewsTabBody extends StatelessWidget {
  const MovieReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          if (state.response.isEmpty) {
            return const EmptySectionMessage(
              icon: Icons.reviews_outlined,
              title: "No reviews yet",
              subTitle: "Stay tuned for upcoming community feedback",
            );
          }
          return ReviewsList(reviews: state.response);
        } else if (state is ReviewsLoading) {
          return Column(
            children: [
              verticalSpacing(100),
              const Center(child: CircularProgressIndicator()),
              verticalSpacing(150),
            ],
          );
        } else if (state is ReviewsError) {
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
