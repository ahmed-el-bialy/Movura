import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/search/data/models/search_sort_type.dart';

import 'sort_toggle_chip.dart';

class FilterSortingSection extends StatelessWidget {
  const FilterSortingSection({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  final SearchSortType selectedSort;
  final ValueChanged<SearchSortType> onSortSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: SearchSortType.values.map((sort) {
        final isSelected = selectedSort == sort;
        return SortToggleChip(
          label: sort.label,
          isSelected: isSelected,
          onTap: () => onSortSelected(sort),
        );
      }).toList(),
    );
  }
}
