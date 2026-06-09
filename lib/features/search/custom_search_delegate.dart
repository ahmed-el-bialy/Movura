import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/poster_card.dart';

import '../../core/theming/colors.dart';
import 'logic/search/search_cubit.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchCubit searchCubit;

  Timer? searchTimeResponse;
  String lastQuery = '';

  CustomSearchDelegate({required this.searchCubit});

  @override
  String? get searchFieldLabel => 'Search movies, tv shows...';

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
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(context) {
    if (query.isEmpty) {
      lastQuery = "";
      return Container(color: AppColors.richEerieBlack);
    }
    final currentQuery = query.trim();
    if (currentQuery == lastQuery) {
      return BuildSearchResultsGrid(searchCubit: searchCubit);
    }

    if (searchTimeResponse?.isActive ?? false) searchTimeResponse!.cancel();

    searchTimeResponse = Timer(const Duration(milliseconds: 800), () {
      lastQuery = currentQuery;
      searchCubit.getSearchResults(query: query.trim());
    });

    return BuildSearchResultsGrid(searchCubit: searchCubit);
  }
}

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
                          fontSize: 10.sp),
                      subTextStyle: Styles.font11BoldIceBlueMontserrat.copyWith(
                          fontSize: 10.sp),
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
