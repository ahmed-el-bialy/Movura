# Implementation Plan - UI Refinement, Navigation Persistence, and Search Optimization

This plan addresses several UI/UX improvements, including reverting the Category list to a `PageView`, fixing search filter visibility issues, and preventing redundant API requests during navigation.

## User Review Required

> [!IMPORTANT]
> - **Navigation Logic**: To prevent redundant API requests when returning to the Home screen, I will move the global Cubits (Trending, Top Rated) to be provided above the `MaterialApp` in `main.dart`. This ensures they live for the entire app lifecycle and keep their data.
> - **Platform Button**: The "Go to Platform" button will now open a professional BottomSheet with options. Since I don't have the specific streaming links for each platform yet, I will provide a clean UI with "Visit Website" and "Share Link" as initial options.

## Proposed Changes

### 1. Global Theming & Spacing
#### [MODIFY] [app_colors.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/theming/app_colors.dart)
- Add more nuanced colors for categories that better match the dark theme.

---

### 2. Home - Category List Redesign
#### [MODIFY] [category_list.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/ui/widgets/category_list.dart)
- Revert from `ListView` to `PageView.builder`.
- Integrate `SmoothPageIndicator`.
- Use a `viewportFraction` of ~0.85 to show a preview of adjacent cards.

---

### 3. Search UI/UX Fixes
#### [MODIFY] [custom_search_delegate.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/custom_search_delegate.dart)
- Ensure that when the "X" button is pressed, the `searchCubit.setFilter(SearchFilterType.all)` is called and the UI reflects this immediately (removing any filter chips).
- Verify and fix any awkward horizontal layouts in the search results.

---

### 4. Details Screen & Platform Navigation
#### [MODIFY] [movie_main_details.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/movie_widgets/movie_main_details.dart) & [tv_main_details.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/tv_main_details.dart)
- **Remove** the "+" (Add to Watchlist) button from the AppBar as requested.
- Update the "Go to Platform" button to show a `ModalBottomSheet` with professional options.

#### [MODIFY] [buttons_row.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/shared_widgets/buttons_row.dart)
- Refine the 3-button layout (Trailer, Watchlist (+), Favorite) for a premium look.

---

### 5. Persistent State & Routing Fix
#### [MODIFY] [main.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/main.dart)
- Wrap the app in `MultiBlocProvider` for the core Home/Trending Cubits.
#### [MODIFY] [app_router.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/routing/app_router.dart)
- Remove `BlocProvider` creation from the `mainScreen` route since they will be global. This prevents re-creation and re-fetching on navigation.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure code quality.

### Manual Verification
- Navigate from Home -> Details -> Home and verify that no loading indicator appears (data is cached).
- Scroll the `CategoryList` and verify the indicator updates.
- Use the Search "X" button and verify filters are reset.
