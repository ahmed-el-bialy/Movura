import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';

import 'genre_chip_group.dart';

class FilterGenresSection extends StatelessWidget {
  const FilterGenresSection({
    super.key,
    required this.genres,
    required this.selectedGenreId,
    required this.onGenreSelected,
  });

  final List<GenreModel> genres;
  final int? selectedGenreId;
  final ValueChanged<int?> onGenreSelected;

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return SizedBox(
        height: 120.h,
        child: const Center(child: MovuraLoadingIndicator(size: 45)),
      );
    }

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: genres.map((genre) {
        final isSelected = selectedGenreId == genre.id;
        return RefinedChip(
          label: genre.name,
          isSelected: isSelected,
          onTap: (selected) {
            onGenreSelected(selected ? genre.id : null);
          },
        );
      }).toList(),
    );
  }
}
