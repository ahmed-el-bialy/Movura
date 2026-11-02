import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

import '../../data/models/search_filter_type.dart';
import '../../data/models/search_sort_type.dart';
import '../../logic/search/search_cubit.dart';
import 'filter_sheet_widgets/filter_action_bar.dart';
import 'filter_sheet_widgets/filter_genres_section.dart';
import 'filter_sheet_widgets/filter_search_in_grid.dart';
import 'filter_sheet_widgets/filter_sheet_header.dart';
import 'filter_sheet_widgets/filter_sorting_section.dart';

class SearchFilterSheet extends StatefulWidget {
  const SearchFilterSheet({
    super.key,
    required this.searchCubit,
    required this.onFilterSelected,
  });

  final SearchCubit searchCubit;
  final VoidCallback onFilterSelected;

  static Future<void> show(
    BuildContext context, {
    required SearchCubit searchCubit,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, anim1, anim2) {
        return SearchFilterSheet(
          searchCubit: searchCubit,
          onFilterSelected: () => dialogContext.pop(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late SearchFilterType _tempFilter;
  int? _tempGenreId;
  late SearchSortType _tempSort;

  @override
  void initState() {
    super.initState();
    _tempFilter = widget.searchCubit.currentFilter;
    _tempGenreId = widget.searchCubit.selectedGenreId;
    _tempSort = widget.searchCubit.currentSort;
    widget.searchCubit.fetchGenres().then((_) {
      if (mounted) setState(() {});
    });
  }

  void _applyFilters() {
    widget.searchCubit.setFilter(_tempFilter);
    widget.searchCubit.setGenreFilter(_tempGenreId);
    widget.searchCubit.setSortType(_tempSort);
    widget.onFilterSelected();
  }

  @override
  Widget build(BuildContext context) {
    List<GenreModel> currentGenres = [];
    if (_tempFilter == SearchFilterType.movies) {
      currentGenres = widget.searchCubit.movieGenres;
    } else if (_tempFilter == SearchFilterType.tv) {
      currentGenres = widget.searchCubit.tvGenres;
    } else {
      currentGenres = widget.searchCubit.movieGenres;
    }

    String selectionSummary = _tempFilter.label;
    if (_tempGenreId != null) {
      final genre = currentGenres.firstWhere(
        (g) => g.id == _tempGenreId,
        orElse: () => GenreModel(id: -1, name: ''),
      );
      if (genre.name.isNotEmpty) {
        selectionSummary += ' • ${genre.name}';
      }
    }
    if (_tempSort != SearchSortType.none) {
      selectionSummary += ' • ${_tempSort.label}';
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: AppColors.transparent,
        insetPadding: AppSpacing.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.xxl,
        ),
        child: Container(
          padding: AppSpacing.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.charcoalBlack.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(36.r),
            border: Border.all(
              color: AppColors.neonBlue.withValues(alpha: 0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withValues(alpha: 0.12),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Refine Search',
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 22.sp,
                      letterSpacing: -0.5,
                      fontWeight: Weights.extraBold,
                    ),
                  ),
                  HeaderCloseButton(onPressed: () => context.pop()),
                ],
              ),
              AppSpacing.verticalSpacing(20),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FilterSectionHeader(
                        icon: Icons.auto_awesome_motion_rounded,
                        title: 'SEARCH IN',
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      FilterSearchInGrid(
                        selectedFilter: _tempFilter,
                        onFilterSelected: (filter) {
                          setState(() {
                            _tempFilter = filter;
                            _tempGenreId = null;
                          });
                        },
                      ),
                      if (_tempFilter != SearchFilterType.people) ...[
                        AppSpacing.verticalSpacing(AppSpacing.xxl),
                        const FilterSectionHeader(
                          icon: Icons.interests_rounded,
                          title: 'GENRES',
                        ),
                        AppSpacing.verticalSpacing(AppSpacing.l),
                        FilterGenresSection(
                          genres: currentGenres,
                          selectedGenreId: _tempGenreId,
                          onGenreSelected: (id) {
                            setState(() => _tempGenreId = id);
                          },
                        ),
                      ],
                      AppSpacing.verticalSpacing(AppSpacing.xxl),
                      const FilterSectionHeader(
                        icon: Icons.sort_rounded,
                        title: 'SORTING',
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      FilterSortingSection(
                        selectedSort: _tempSort,
                        onSortSelected: (sort) {
                          setState(() => _tempSort = sort);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalSpacing(20),
              SelectionSummaryBar(summary: selectionSummary),
              AppSpacing.verticalSpacing(20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SmallActionButton(
                      label: 'Reset',
                      onPressed: () {
                        setState(() {
                          _tempFilter = SearchFilterType.all;
                          _tempGenreId = null;
                          _tempSort = SearchSortType.none;
                        });
                      },
                      isSecondary: true,
                    ),
                  ),
                  AppSpacing.horizontalSpacing(AppSpacing.l),
                  Expanded(
                    flex: 2,
                    child: SmallActionButton(
                      label: 'Apply Filters',
                      onPressed: _applyFilters,
                      isSecondary: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
