import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/poster_card.dart';

import '../../core/theming/colors.dart';
import 'logic/search/search_cubit.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchCubit searchCubit;

  CustomSearchDelegate({required this.searchCubit});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: AppColors.charcoalBlack),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.coolGray, fontSize: 16.sp),
        border: InputBorder.none,

        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: AppColors.slateGray, fontSize: 16.sp),
      ),
    );
  }

  @override
  List<Widget>? buildActions(context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear, color: AppColors.neonCyan),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.filter_alt, color: AppColors.neonCyan),
      ),
    ];
  }

  @override
  Widget? buildLeading(context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: AppColors.neonCyan),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(color: AppColors.richEerieBlack);
    }

    searchCubit.getSearchResults(query: query.trim());

    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is SearchLoading) {
          return Expanded(
            child: Container(
              color: AppColors.jetBlack,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.neonCyan),
              ),
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
                  childAspectRatio: .6,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PosterCard(
                      mediaModel: state.posters[index],
                      elevation: 5,
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

  @override
  Widget buildSuggestions(context) {
    return Container(color: AppColors.jetBlack);
  }
}
