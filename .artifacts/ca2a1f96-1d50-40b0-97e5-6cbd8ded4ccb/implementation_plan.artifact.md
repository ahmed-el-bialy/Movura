# Implementation Plan - Final Functional & UI Perfection

This plan focuses on restoring the video player stability, implementing real platform navigation, redesigning the Library screen, and refining the Search/Details UX.

## User Review Required

> [!IMPORTANT]
> - **Video Player Revert**: I will downgrade `youtube_player_flutter` to `^9.1.3` and restore the original code for stable orientation handling.
> - **Library Feature**: I will rename the "Categories" feature to "Library" and design it to show a professional overview of the user's collections (Watchlist, Favorites, etc.).
> - **Dependencies**: I will assume `url_launcher` is added to `pubspec.yaml` to implement the "Visit Website" functionality.

## Proposed Changes

### 1. Video Player Restoration (Revert)
#### [MODIFY] [pubspec.yaml](file:///home/uzumaki/Development/Flutter /Personal/Movura/pubspec.yaml)
- Revert `youtube_player_flutter` to `^9.1.3`.
#### [MODIFY] [video_player.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/helpers/video_player.dart) & [video_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/screens/video_screen.dart)
- Restore original controller flags and system orientation management logic.

---

### 2. Search UX Refinement
#### [MODIFY] [custom_search_delegate.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/custom_search_delegate.dart)
- Add a visual indicator (badge or color change) to the filter icon when a non-default filter is active.
- Ensure clearing the search resets all filters and updates the UI immediately.

---

### 3. Details Functional Enhancements
#### [MODIFY] [platform_options_sheet.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/shared_widgets/platform_options_sheet.dart)
- Use a `Wrap` widget for streaming provider logos for better multi-row layout.
- Implement `url_launcher` logic for the "Visit Website" button.
- Implement `Clipboard` logic for the "Copy Link" option.

#### [MODIFY] [watchlist_options_sheet.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/shared_widgets/watchlist_options_sheet.dart)
- Redesign the layout from a `Column` of tiles to a `Row` of action buttons (circular icon with text below).

---

### 4. Library Screen (Renamed Feature)
#### [RENAME] `lib/features/categories/` -> `lib/features/library/`
#### [MODIFY] [library_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/library/ui/screens/library_screen.dart)
- Design a professional UI that displays "Watchlist", "Favorites", and "Watched" categories with counts and quick previews.
- Give it a modern "AI/System" aesthetic with clean borders and typography.

---

### 5. Final Cleanup & Git
- Ensure all spacing helpers are used.
- Final commit and push.

## Verification Plan

### Automated Tests
- Run `flutter analyze`.

### Manual Verification
- Test video player rotation and full-screen view.
- Verify that "Visit Website" opens the browser.
- Check that the search filter icon correctly shows an active state.
- review the new Library UI and Watchlist Row layout.
