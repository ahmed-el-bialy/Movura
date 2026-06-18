import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/empty_section_message.dart';

import '../../../logic/movie_screen_cubit/reviews/reviews_cubit.dart';
import '../shared_widgets/reviews_list.dart';

class MovieReviewsTabBody extends StatelessWidget {
  const MovieReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          if (state.response.isEmpty) {
            return EmptySectionMessage(
              icon: Icons.reviews_outlined,
              title: "No reviews yet",
              subTitle: "Stay tuned for upcoming community feedback",
            );
          }
          return ReviewsList(reviews: state.response);
        } else if (state is ReviewsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ReviewsFailed) {
          return Center(
            child: Text(state.errorMessage, style: AppTextStyles.font11BoldGold),
          );
        } else {
          return Text(
            " there was an error",
            style: AppTextStyles.font13MediumNeonBlue,
          );
        }
      },
    );
  }
}
