import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details_screen/logic/reviews/reviews_cubit.dart';
import 'package:movura/features/details_screen/ui/widgets/reviews_tab/review_card.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          if (state.response.isEmpty) {
            return const Center(
              child: Text(
                "No reviews available for this movie",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
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
              itemCount: state.response.length,
                itemBuilder: (context, index) {
                  return ReviewCard(model: state.response[index],);
                },
              ),
            ],
          );
        } else if (state is ReviewsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ReviewsFailed) {
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
