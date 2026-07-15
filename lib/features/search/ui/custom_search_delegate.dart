import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/search/ui/widgets/build_search_results.dart';

import '../../../core/theming/app_colors.dart';
import '../logic/search/search_cubit.dart';

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
        icon: Icon(Icons.clear, color: AppColors.neonBlue),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.filter_alt, color: AppColors.neonBlue),
      ),
    ];
  }

  @override
  Widget? buildLeading(context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: AppColors.neonBlue),
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
