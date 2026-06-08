import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/poster_card.dart';
import 'package:movura/features/home_screen/logic/top_rated_movie/top_rated_movie_cubit.dart';

class SubPosterListBuilder extends StatelessWidget {
  const SubPosterListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoaded) {
          return SizedBox(
            height: 220.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.posters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0.w,
                    vertical: 12.h,
                  ),
                  child: PosterCard(
                    height: 180,
                    width: 150,
                    elevation: 2,
                    border: 12,
                    titleStyle: Styles.font14BoldIceBlueMontserrat,
                    subCardElevation: 3,
                    subTextStyle: Styles.font11BoldGold,
                    mediaModel: state.posters[index],
                    mediaType: "movie",
                  ),
                );
              },
            ),
          );
        } else if (state is TopRatedMovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TopRatedMovieFailed) {
          return Center(
            child: Text(state.errorMessage, style: Styles.font11BoldGold),
          );
        } else {
          return Center(
            child: Text(
              "there is an error : ${state.toString()}",
              style: Styles.font11BoldGold,
            ),
          );
        }
      },
    );
  }
}
