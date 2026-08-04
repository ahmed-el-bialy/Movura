import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';

import '../../data/models/search_filter_type.dart';
import '../../data/models/search_sort_type.dart';
import '../../logic/search/search_cubit.dart';

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
      pageBuilder: (context, anim1, anim2) {
        return SearchFilterSheet(
          searchCubit: searchCubit,
          onFilterSelected: () => Navigator.pop(context),
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
                  _HeaderCloseButton(onPressed: () => context.pop()),
                ],
              ),
              AppSpacing.verticalSpacing(20),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionHeader(
                        icon: Icons.auto_awesome_motion_rounded,
                        title: 'SEARCH IN',
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 2.6,
                        ),
                        itemCount: SearchFilterType.values.length,
                        itemBuilder: (context, index) {
                          final filter = SearchFilterType.values[index];
                          final isSelected = filter == _tempFilter;
                          return _FilterOptionTile(
                            label: filter.label,
                            icon: _iconFor(filter),
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _tempFilter = filter;
                                _tempGenreId = null;
                              });
                            },
                          );
                        },
                      ),
                      if (_tempFilter != SearchFilterType.people) ...[
                        AppSpacing.verticalSpacing(AppSpacing.xxl),
                        const _SectionHeader(
                          icon: Icons.interests_rounded,
                          title: 'GENRES',
                        ),
                        AppSpacing.verticalSpacing(AppSpacing.l),
                        if (currentGenres.isEmpty)
                          SizedBox(
                            height: 120.h,
                            child: const Center(
                              child: MovuraLoadingIndicator(size: 45),
                            ),
                          )
                        else
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: currentGenres.map((genre) {
                              final isSelected = _tempGenreId == genre.id;
                              return _RefinedChip(
                                label: genre.name,
                                isSelected: isSelected,
                                onTap: (selected) {
                                  setState(() {
                                    _tempGenreId = selected ? genre.id : null;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                      ],
                      AppSpacing.verticalSpacing(AppSpacing.xxl),
                      const _SectionHeader(
                        icon: Icons.sort_rounded,
                        title: 'SORTING',
                      ),
                      AppSpacing.verticalSpacing(AppSpacing.l),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: SearchSortType.values.map((sort) {
                          final isSelected = _tempSort == sort;
                          return _SortToggleChip(
                            label: sort.label,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _tempSort = sort;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalSpacing(20),
              _SelectionSummaryBar(summary: selectionSummary),
              AppSpacing.verticalSpacing(20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _SmallActionButton(
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
                    child: _SmallActionButton(
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

  IconData _iconFor(SearchFilterType filter) {
    return switch (filter) {
      SearchFilterType.all => Icons.all_inclusive_rounded,
      SearchFilterType.movies => Icons.movie_filter_rounded,
      SearchFilterType.tv => Icons.live_tv_rounded,
      SearchFilterType.people => Icons.people_alt_rounded,
    };
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.neonBlue.withValues(alpha: 0.8),
          size: 16.sp,
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        Text(
          title,
          style: TextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 2.0,
            color: AppColors.coolGray.withValues(alpha: 0.6),
            fontWeight: Weights.black,
          ),
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.neonBlue.withValues(alpha: 0.15),
          ),
        ),
      ],
    );
  }
}

class _HeaderCloseButton extends StatelessWidget {
  const _HeaderCloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: AppSpacing.all(4),
        constraints: const BoxConstraints(),
        icon: Icon(Icons.close_rounded, color: AppColors.coolGray, size: 20.sp),
      ),
    );
  }
}

class _FilterOptionTile extends StatelessWidget {
  const _FilterOptionTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Material(
        color: isSelected
            ? AppColors.neonBlue.withValues(alpha: 0.12)
            : AppColors.onyxBlack.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          splashColor: AppColors.neonBlue.withValues(alpha: 0.15),
          child: Container(
            padding: AppSpacing.horizontal(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.neonBlue.withValues(alpha: 0.6)
                    : AppColors.slateGray.withValues(alpha: 0.08),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.neonBlue : AppColors.coolGray,
                  size: 18.sp,
                ),
                AppSpacing.horizontalSpacing(10),
                Expanded(
                  child: Text(
                    label,
                    style:
                        (isSelected
                                ? TextStyles.font13BoldNeonBlueSora
                                : TextStyles.font14RegularPureWhiteManrope)
                            .copyWith(
                              fontSize: 12.sp,
                              fontWeight: isSelected
                                  ? Weights.extraBold
                                  : Weights.medium,
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RefinedChip extends StatelessWidget {
  const _RefinedChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onTap,
      backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.4),
      selectedColor: AppColors.neonBlue.withValues(alpha: 0.25),
      labelStyle: TextStyles.font10MediumCoolGraySora.copyWith(
        color: isSelected
            ? AppColors.neonBlue
            : AppColors.pureWhite.withValues(alpha: 0.7),
        fontSize: 11.sp,
        fontWeight: isSelected ? Weights.bold : Weights.regular,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected
              ? AppColors.neonBlue.withValues(alpha: 0.7)
              : AppColors.coolGray.withValues(alpha: 0.1),
        ),
      ),
      showCheckmark: false,
      elevation: 0,
      padding: AppSpacing.symmetric(horizontal: 10, vertical: 6),
    );
  }
}

class _SortToggleChip extends StatelessWidget {
  const _SortToggleChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: AppSpacing.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.neonBlue.withValues(alpha: 0.15)
              : AppColors.onyxBlack.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? AppColors.neonBlue
                : AppColors.coolGray.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.sort_rounded,
              size: 16.sp,
              color: isSelected ? AppColors.neonBlue : AppColors.coolGray,
            ),
            AppSpacing.horizontalSpacing(10),
            Text(
              label,
              style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                color: isSelected
                    ? AppColors.neonBlue
                    : AppColors.pureWhite.withValues(alpha: 0.7),
                fontSize: 12.sp,
                fontWeight: isSelected ? Weights.extraBold : Weights.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionSummaryBar extends StatelessWidget {
  const _SelectionSummaryBar({required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.symmetric(horizontal: AppSpacing.l, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.flash_on_rounded, color: AppColors.gold, size: 14),
          AppSpacing.horizontalSpacing(AppSpacing.m),
          Expanded(
            child: Text(
              summary,
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                fontSize: 11.sp,
                color: AppColors.iceBlue.withValues(alpha: 0.6),
                fontWeight: Weights.bold,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  const _SmallActionButton({
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    if (isSecondary) {
      return SizedBox(
        height: 30.h,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.softRed,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            label,
            style: TextStyles.font14RegularPureWhiteManrope.copyWith(
              color: AppColors.softRed,
              fontWeight: Weights.black,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.neonBlue, AppColors.tealCyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyles.font17BoldTrueBlackSora.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
            fontWeight: Weights.black,
          ),
        ),
      ),
    );
  }
}
