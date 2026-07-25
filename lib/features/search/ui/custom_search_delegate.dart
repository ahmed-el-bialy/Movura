import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/ui/widgets/build_search_results.dart';
import 'package:movura/features/search/ui/widgets/search_filter_sheet.dart';
import 'package:movura/features/search/ui/widgets/sub_widgets/search_empty_state.dart';
import '../../../core/theming/app_colors.dart';
import '../logic/search/search_cubit.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchCubit searchCubit;
  Timer? searchTimeResponse;
  String lastQuery = '';

  CustomSearchDelegate({required this.searchCubit});

  @override
  String? get searchFieldLabel => 'Search movies, tv shows, people...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.charcoalBlack,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColors.slateGray.withValues(alpha: 0.6),
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.iceBlue,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    await SearchFilterSheet.show(context, searchCubit: searchCubit);
    if (query.trim().isNotEmpty) {
      lastQuery = '';
      searchCubit.getSearchResults(query: query.trim());
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final bool isFiltered =
        searchCubit.currentFilter != SearchFilterType.all ||
        searchCubit.selectedGenreId != null ||
        searchCubit.sortByRating;

    return [
      IconButton(
        onPressed: () {
          query = '';
          searchCubit.setFilter(SearchFilterType.all);
          searchCubit.setGenreFilter(null);
          searchCubit.setSortByRating(false);
          showSuggestions(context);
        },
        icon: Icon(
          Icons.clear,
          color: isFiltered ? AppColors.softRed : AppColors.neonBlue,
        ),
      ),
      IconButton(
        onPressed: () => _openFilterSheet(context),
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              isFiltered ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,
              color: AppColors.neonBlue,
              size: 26.sp,
            ),
            if (isFiltered)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: BoxDecoration(
                    color: AppColors.amberGold,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.charcoalBlack,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back, color: AppColors.neonBlue),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      lastQuery = '';
      return SearchEmptyState(filter: searchCubit.currentFilter);
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
