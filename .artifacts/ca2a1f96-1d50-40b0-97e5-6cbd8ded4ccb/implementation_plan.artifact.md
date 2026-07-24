# Implementation Plan - Enhancing Episode Details and Search Filtering

This plan aims to professionalize the `EpisodeDetailsScreen` and enhance the `Search` functionality with advanced filtering, following the project's existing architecture and style.

## User Review Required

> [!IMPORTANT]
> - I will be adding `images` and `videos` to the `EpisodeDetailsModel`. This requires running `build_runner` to update the generated files.
> - I will add "Next/Previous Episode" navigation. This requires updating `EpisodeArgumentsModel` to include the total number of episodes in the season.

## Proposed Changes

### Core & Models

#### [MODIFY] [episode_details_model.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/data/models/tv_models/episode_details_model.dart)
- Add `TvVideoResponse? videos` and `TvImagesResponse? images` fields.
- Update constructor and JSON serialization.

#### [MODIFY] [arguments_model.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/routing/arguments_model.dart)
- Add `totalEpisodes` to `EpisodeArgumentsModel` to enable navigation.

---

### UI - Episode Details

#### [MODIFY] [episode_details_body.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/episode_widgets/episode_details_body.dart)
- Add `VideosList` section.
- Add `ImagesList` section.
- Implement a bottom navigation row for "Previous Episode" and "Next Episode".
- Improve overall styling and animations (e.g., using `SliverToBoxAdapter` for new sections).

#### [MODIFY] [episode_details_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/screens/episode_details_screen.dart)
- Update to handle navigation between episodes if possible (by re-providing the Cubit or updating the state).

---

### UI - Search Filtering

#### [MODIFY] [search_filter_sheet.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/widgets/search_filter_sheet.dart)
- Redesign the sheet to be more professional.
- Add "Release Year" or "Sort By" options (UI only for now, logic to follow if API supports).

#### [MODIFY] [search_cubit.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/logic/search/search_cubit.dart)
- Refine filtering logic.

---

### Git Workflow
- Perform atomic commits for each major change.
- Push to GitHub.

## Verification Plan

### Automated Tests
- Since the project has a `test` folder, I will check if there are relevant tests to run.
- Run `flutter test` if applicable.

### Manual Verification
- Render Compose previews if applicable (though this is Flutter, so I'll rely on code quality).
- Verify the UI layout in the code.
