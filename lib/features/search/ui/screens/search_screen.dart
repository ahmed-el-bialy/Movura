import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';

import '../../data/models/search_filter_type.dart';
import '../../data/models/search_sort_type.dart';
import '../../logic/search/search_cubit.dart';

import '../widgets/search_filter_sheet.dart';
import '../widgets/search_results_grid.dart';
import '../widgets/search_ui_widgets/search_empty_state.dart';
import '../widgets/search_ui_widgets/search_filter_bar.dart';
import '../widgets/search_ui_widgets/search_filter_icon_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  void initState() {
    super.initState();
    _searchCubit.fetchGenres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        _searchCubit.getSearchResults(query: query.trim());
      } else {
        _searchCubit.setFilter(_searchCubit.currentFilter);
      }
    });
  }

  Future<void> _openFilterSheet() async {
    await SearchFilterSheet.show(context, searchCubit: _searchCubit);
    if (_searchController.text.trim().isNotEmpty) {
      _searchCubit.getSearchResults(query: _searchController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        body: SafeArea(
          child: Column(
            children: [
              AppSpacing.verticalSpacing(15),
              Padding(
                padding: AppSpacing.horizontal16(),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: AppSpacing.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.charcoalBlack,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.coolGray.withValues(alpha: 0.2),
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: TextStyles.font14SemiBoldPlatinumGraySora,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.search_rounded,
                              color: AppColors.neonBlue,
                              size: 22.sp,
                            ),
                            hintText: 'Search movies, TV shows, people...',
                            hintStyle: TextStyles.font12RegularCoolGrayManrope
                                .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.slateGray.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSpacing(12),
                    FilterIconButton(
                      onTap: _openFilterSheet,
                      isFiltered:
                          _searchCubit.currentFilter != SearchFilterType.all ||
                          _searchCubit.selectedGenreId != null ||
                          _searchCubit.currentSort != SearchSortType.none,
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalSpacing(15),
              SearchFilterBar(searchCubit: _searchCubit),
              AppSpacing.verticalSpacing(10),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: MovuraLoadingIndicator());
                    } else if (state is SearchLoaded) {
                      return SearchResultsGrid(searchCubit: _searchCubit);
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: AppColors.softRed),
                        ),
                      );
                    }
                    return SearchEmptyState(filter: _searchCubit.currentFilter);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
