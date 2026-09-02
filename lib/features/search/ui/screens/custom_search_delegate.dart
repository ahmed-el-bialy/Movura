import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

import '../../data/models/search_filter_type.dart';
import '../../logic/search/search_cubit.dart';
import '../widgets/search_filter_sheet.dart';
import '../widgets/search_results_grid.dart';
import '../widgets/search_ui_widgets/search_empty_state.dart';

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
        hintStyle: TextStyles.font12RegularCoolGrayManrope.copyWith(
          color: AppColors.slateGray.withValues(alpha: 0.6),
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyles.font17BoldIceBlueMontserrat.copyWith(
          color: AppColors.iceBlue,
          fontSize: 18.sp,
          fontWeight: Weights.medium,
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
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear, color: AppColors.neonBlue),
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
      return SearchResultsGrid(searchCubit: searchCubit);
    }

    if (searchTimeResponse?.isActive ?? false) searchTimeResponse!.cancel();

    searchTimeResponse = Timer(const Duration(milliseconds: 350), () {
      lastQuery = currentQuery;
      searchCubit.getSearchResults(query: query.trim());
    });

    return SearchResultsGrid(searchCubit: searchCubit);
  }
}
