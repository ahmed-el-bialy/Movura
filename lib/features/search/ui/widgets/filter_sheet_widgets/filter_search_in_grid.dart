import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';

import 'filter_option_tile.dart';

class FilterSearchInGrid extends StatelessWidget {
  const FilterSearchInGrid({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final SearchFilterType selectedFilter;
  final ValueChanged<SearchFilterType> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        final isSelected = filter == selectedFilter;
        return FilterOptionTile(
          label: filter.label,
          icon: _iconFor(filter),
          isSelected: isSelected,
          onTap: () => onFilterSelected(filter),
        );
      },
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
