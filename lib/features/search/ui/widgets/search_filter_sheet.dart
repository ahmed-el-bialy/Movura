import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';

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
  late bool _tempSortByRating;

  @override
  void initState() {
    super.initState();
    _tempFilter = widget.searchCubit.currentFilter;
    _tempGenreId = widget.searchCubit.selectedGenreId;
    _tempSortByRating = widget.searchCubit.sortByRating;
    widget.searchCubit.fetchGenres().then((_) {
      if (mounted) setState(() {});
    });
  }

  void _applyFilters() {
    widget.searchCubit.setFilter(_tempFilter);
    widget.searchCubit.setGenreFilter(_tempGenreId);
    widget.searchCubit.setSortByRating(_tempSortByRating);
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
    if (_tempSortByRating) {
      selectionSummary += ' • Top Rated';
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Container(
          padding: EdgeInsets.all(24.r),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Refine Search',
                      style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                        fontSize: 22.sp,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    _HeaderCloseButton(onPressed: () => context.pop()),
                  ],
                ),
                verticalSpacing(28),
                _buildSectionHeader(
                  Icons.auto_awesome_motion_rounded,
                  'SEARCH IN',
                ),
                verticalSpacing(16),
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
                if (currentGenres.isNotEmpty &&
                    _tempFilter != SearchFilterType.people) ...[
                  verticalSpacing(32),
                  _buildSectionHeader(Icons.interests_rounded, 'GENRES'),
                  verticalSpacing(16),
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
                verticalSpacing(32),
                _buildSectionHeader(Icons.sort_rounded, 'SORTING'),
                verticalSpacing(16),
                _SortToggleChip(
                  label: 'Highly Rated Content',
                  isSelected: _tempSortByRating,
                  onTap: () {
                    setState(() {
                      _tempSortByRating = !_tempSortByRating;
                    });
                  },
                ),
                verticalSpacing(40),
                _SelectionSummaryBar(summary: selectionSummary),
                verticalSpacing(28),
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
                            _tempSortByRating = false;
                          });
                        },
                        isSecondary: true,
                      ),
                    ),
                    horizontalSpacing(16),
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
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.neonBlue.withValues(alpha: 0.8),
          size: 16.sp,
        ),
        horizontalSpacing(12),
        Text(
          title,
          style: AppTextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 2.0,
            color: AppColors.coolGray.withValues(alpha: 0.6),
            fontWeight: FontWeight.w900,
          ),
        ),
        horizontalSpacing(12),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.neonBlue.withValues(alpha: 0.15),
          ),
        ),
      ],
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
        padding: EdgeInsets.all(4.r),
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
            padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                horizontalSpacing(10),
                Expanded(
                  child: Text(
                    label,
                    style:
                        (isSelected
                                ? AppTextStyles.font13BoldNeonBlueSora
                                : AppTextStyles.font14PureWhiteManrope)
                            .copyWith(
                              fontSize: 12.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
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
      labelStyle: TextStyle(
        color: isSelected
            ? AppColors.neonBlue
            : Colors.white.withValues(alpha: 0.7),
        fontSize: 11.sp,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
              isSelected ? Icons.auto_graph_rounded : Icons.sort_rounded,
              size: 16.sp,
              color: isSelected ? AppColors.neonBlue : AppColors.coolGray,
            ),
            horizontalSpacing(10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.neonBlue : Colors.white70,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.flash_on_rounded, color: AppColors.gold, size: 14),
          horizontalSpacing(12),
          Expanded(
            child: Text(
              summary,
              style: AppTextStyles.font12CoolGrayManrope.copyWith(
                fontSize: 11.sp,
                color: AppColors.iceBlue.withValues(alpha: 0.6),
                fontWeight: FontWeight.w700,
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
            style: AppTextStyles.font14PureWhiteManrope.copyWith(
              color: AppColors.softRed,
              fontWeight: FontWeight.w900,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTextStyles.font17BoldTrueBlackSora.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
