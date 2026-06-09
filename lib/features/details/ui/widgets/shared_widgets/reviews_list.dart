import 'package:flutter/material.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/review_card.dart';

import '../../../../../core/widgets/section_title.dart';
import '../../../data/models/shared_models/review_model.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key, required this.reviews});

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          sectionName: "REVIEWS",
          actionName: "VIEW ALL",
          onTap: () {},
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(model: reviews[index]);
          },
        ),
      ],
    );
  }
}
