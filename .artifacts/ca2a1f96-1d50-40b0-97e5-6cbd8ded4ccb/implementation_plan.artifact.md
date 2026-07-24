# Implementation Plan - Advanced Filtering, Theming, and Platform Navigation

This plan focuses on enhancing the search experience with genre-based filtering, adhering to strict theming standards, and adding essential navigation features to the details screens.

## User Review Required

> [!IMPORTANT]
> - **Dependency Needed**: I will implement the UI for the "Go to Platform" button, but you will need to add `url_launcher` to your `pubspec.yaml` to make it functional.
> - **Genre Data**: I will add `genreIds` to the `PosterModel`. You will need to run `build_runner` to update the generated files.
> - **Search UX**: I will modify the "X" clear button in search to also reset the media type filter to "All", as requested.

## Proposed Changes

### 1. Theming & Color Standardization
#### [MODIFY] [app_colors.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/theming/app_colors.dart)
- Add professional category colors: `vibrantPurple`, `electricBlueAccent`, `deepTeal`, `royalIndigo`.
#### [MODIFY] [category_card_model.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/data/models/category_card_model.dart)
- Change `MaterialColor` to `Color`.
#### [MODIFY] [category_list.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/ui/widgets/category_list.dart)
- Update data to use colors from `AppColors`.

---

### 2. Search & Genre Filtering
#### [MODIFY] [poster_model.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/models/poster_model.dart)
- Add `List<int>? genreIds` to `PosterModel`.
#### [MODIFY] [custom_search_delegate.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/custom_search_delegate.dart)
- Fix the "X" button bug: Clear button will now reset the search filter to `All`.
- Ensure UI rebuilds correctly when the filter is cleared.
#### [MODIFY] [search_filter_sheet.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/widgets/search_filter_sheet.dart)
- Add a **Genres / Animation** section.
- Implementation of "Animation / Anime" specifically as a prominent genre filter.
- Sub-filters (Genres) will dynamically show/hide based on the selected media type (Movie vs TV).

---

### 3. Details Screen Enhancements
#### [MODIFY] [movie_main_details.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/movie_widgets/movie_main_details.dart) & [tv_main_details.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/tv_main_details.dart)
- Move the "Favorite" button inside a more appropriate place (e.g., in a settings menu or the buttons row).
- Add the **"Go to Platform"** button in the AppBar for high visibility.
- Add the **"+" (Add to Watchlist)** button with a professional UI.

---

### 4. Code Cleanup & Standards
- Ensure all new components are `StatelessWidget` or `StatefulWidget`.
- Use the project's spacing helpers (`verticalSpacing`, etc.) exclusively.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to verify the project's health.

### Manual Verification
- Verify that searching and then clearing resets both text and filters.
- Test the "Animation/Anime" filter to ensure it correctly filters results locally.
- Review the new details screen layout with "Go to Platform" and "+" buttons.
