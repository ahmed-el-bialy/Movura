import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/logic/reviews/reviews_cubit.dart';

class ReviewsTabBody extends StatelessWidget {
  const ReviewsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          return ListView.builder(itemBuilder: (context, index) {
            return Text("data",style: Styles.font11BoldGold,);
          });
        } else if (state is ReviewsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ReviewsFailed) {
          return Center(
              child: Text(state.errorMessage, style: Styles.font11BoldGold,));
        }
        else {
          return Text(
            " there was an error", style: Styles.font13MediumNeonCyan,);
        }
      },
    );
  }
}
