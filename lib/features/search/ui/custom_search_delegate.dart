import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/ui/widgets/sub_widgets/search_empty_state.dart';
import 'package:movura/features/search/ui/widgets/build_search_results.dart';
import 'package:movura/features/search/ui/widgets/search_filter_sheet.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/text_styles.dart';
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
      appBarTheme: AppBarTheme(
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
    await SearchFilterSheet.show(
      context,
      searchCubit: searchCubit,
    );
    // Sheet will call cubit methods directly, then pop.
    // Re-trigger suggestions if query is not empty
    if (query.trim().isNotEmpty) {
      lastQuery = '';
      searchCubit.getSearchResults(query: query.trim());
    }
  }

  @override
  List<Widget>? buildActions(context) {
    return [
      if (searchCubit.currentFilter != SearchFilterType.all)
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Chip(
            label: Text(
              searchCubit.currentFilter.label,
              style: AppTextStyles.font12CoolGrayManrope.copyWith(
                color: AppColors.neonBlue,
                fontSize: 11.sp,
              ),
            ),
            backgroundColor: AppColors.neonBlue.withValues(alpha: 0.12),
            side: BorderSide(color: AppColors.neonBlue.withValues(alpha: 0.4)),
            visualDensity: VisualDensity.compact,
            onDeleted: () {
              searchCubit.setFilter(SearchFilterType.all);
              if (query.trim().isNotEmpty) {
                lastQuery = '';
                searchCubit.getSearchResults(query: query.trim());
              }
            },
          ),
        ),
      IconButton(
        onPressed: () {
          query = '';
          searchCubit.setFilter(SearchFilterType.all);
          searchCubit.setGenreFilter(null);
          showSuggestions(context);
        },
        icon: Icon(Icons.clear, color: AppColors.neonBlue),
      ),
      IconButton(
        onPressed: () => _openFilterSheet(context),
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
