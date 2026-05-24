import 'package:flutter/material.dart';
import 'package:movura/features/details_screen/ui/widgets/reviews_tab/custom_rating_bar.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRatingBar(rating: 9.5)
      ],
    );
  }
}
