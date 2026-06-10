import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/poster_card/poster_card.dart';
import '../../logic/search/search_cubit.dart';

class BuildSearchResultsGrid extends StatelessWidget {
  const BuildSearchResultsGrid({super.key, required this.searchCubit});

  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is SearchLoading) {
          return Container(
            color: AppColors.jetBlack,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.neonCyan),
            ),
          );
        }

        if (state is SearchFounded) {
          if (state.posters.isNotEmpty) {
            return Container(
              color: AppColors.jetBlack,
              child: GridView.builder(
                itemCount: state.posters.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .57,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 6.w,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: PosterCard(
                      border: 10,
                      subCardBorder: 10,
                      mediaModel: state.posters[index],
                      elevation: 5,
                      maxLines: 2,
                      titleStyle: Styles.font11BoldIceBlueMontserrat.copyWith(
                        fontSize: 10.sp,
                      ),
                      subTextStyle: Styles.font11BoldIceBlueMontserrat.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No results found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        }

        if (state is SearchFailed) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Container(color: AppColors.richEerieBlack);
      },
    );
  }
}
