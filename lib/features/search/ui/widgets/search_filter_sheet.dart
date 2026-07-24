import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';

import '../../../../core/helpers/spacing.dart';

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
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoalBlack,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => SearchFilterSheet(
        searchCubit: searchCubit,
        onFilterSelected: () => Navigator.pop(context),
      ),
    );
  }

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late SearchFilterType _tempFilter;
  int? _tempGenreId;

  @override
  void initState() {
    super.initState();
    _tempFilter = widget.searchCubit.currentFilter;
    _tempGenreId = widget.searchCubit.selectedGenreId;
    widget.searchCubit.fetchGenres().then((_) {
      if (mounted) setState(() {});
    });
  }

  void _applyFilters() {
    widget.searchCubit.setFilter(_tempFilter);
    widget.searchCubit.setGenreFilter(_tempGenreId);
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
      // For 'All', show movie genres as default for subfiltering
      currentGenres = widget.searchCubit.movieGenres;
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.slateGray.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            verticalSpacing(20),
            Text(
              'Filter Results',
              style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                fontSize: 18.sp,
              ),
            ),
            verticalSpacing(6),
            Text(
              'Choose media type',
              style: AppTextStyles.font12CoolGrayManrope.copyWith(
                fontSize: 13.sp,
              ),
            ),
            verticalSpacing(20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 2.2,
              ),
              itemCount: SearchFilterType.values.length,
              itemBuilder: (context, index) {
                final filter = SearchFilterType.values[index];
                final isSelected = filter == _tempFilter;
                return Material(
                  color: isSelected
                      ? AppColors.neonBlue.withValues(alpha: 0.15)
                      : AppColors.onyxBlack,
                  borderRadius: BorderRadius.circular(16.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    splashColor: AppColors.neonBlue.withValues(alpha: 0.2),
                    onTap: () {
                      setState(() {
                        _tempFilter = filter;
                        _tempGenreId = null; // Reset genre when changing type
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.neonBlue.withValues(alpha: 0.6)
                              : AppColors.slateGray.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _iconFor(filter),
                            color: isSelected
                                ? AppColors.neonBlue
                                : AppColors.slateGray,
                            size: 20.sp,
                          ),
                          horizontalSpacing(10),
                          Expanded(
                            child: Text(
                              filter.label,
                              style: (isSelected
                                      ? AppTextStyles.font13BoldNeonBlueSora
                                      : AppTextStyles.font14PureWhiteManrope)
                                  .copyWith(fontSize: 13.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (currentGenres.isNotEmpty && _tempFilter != SearchFilterType.people) ...[
              verticalSpacing(24),
              Text(
                'Sub-filters (Genres)',
                style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              verticalSpacing(12),
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentGenres.length,
                  separatorBuilder: (_, __) => horizontalSpacing(10),
                  itemBuilder: (context, index) {
                    final genre = currentGenres[index];
                    final isSelected = _tempGenreId == genre.id;
                    return ChoiceChip(
                      label: Text(genre.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _tempGenreId = selected ? genre.id : null;
                        });
                      },
                      backgroundColor: AppColors.onyxBlack,
                      selectedColor: AppColors.neonBlue.withValues(alpha: 0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.neonBlue : Colors.white70,
                        fontSize: 12.sp,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.neonBlue
                              : AppColors.coolGray.withValues(alpha: 0.3),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            verticalSpacing(32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonBlue,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: AppTextStyles.font17BoldTrueBlackSora.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(SearchFilterType filter) {
    return switch (filter) {
      SearchFilterType.all => Icons.grid_view_rounded,
      SearchFilterType.movies => Icons.movie_outlined,
      SearchFilterType.tv => Icons.tv_outlined,
      SearchFilterType.people => Icons.person_outline_rounded,
    };
  }
}
