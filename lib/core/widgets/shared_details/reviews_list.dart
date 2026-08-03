import 'package:flutter/material.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/widgets/shared_details/review_card.dart';

import '../../models/review_model.dart';
import '../layout/section_title.dart';


class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key, required this.reviews});

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          sectionName: "REVIEWS",
          actionName: AppConstants.sectionAction,
          onTap: () {},
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(model: reviews[index]);
          },
        ),
      ],
    );
  }
}
