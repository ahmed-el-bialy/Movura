# Implementation Plan - Project Cleanup and Optimization

This plan aims to "correct everything" by performing a thorough cleanup, optimizing dependency injection, and ensuring the app is robust against API failures.

## User Review Required

> [!IMPORTANT]
> - I will be updating several Models (Movie and TV) to be more null-safe. This requires running `build_runner`.
> - I will register all major Cubits in `di.dart` for better state management.
> - I will remove unused files and clean up commented-out code.

## Proposed Changes

### 1. Robustness & Model Updates
#### [MODIFY] [about_model.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/data/models/movie_models/about_model.dart)
- Make `posterPath` nullable.
- Make `videoList`, `backdropImages`, `logoImages`, and `movieActors` nullable or default to empty lists in their respective response classes.

---

### 2. Dependency Injection (DI) Optimization
#### [MODIFY] [di.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/networking/di.dart)
- Register `AboutCubit`, `AboutTvCubit`, `TvSeriesReviewsCubit`, `TvSeriesSimilarContentCubit`, and `TvEpisodeDetailsCubit` as factories.

#### [MODIFY] [app_router.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/routing/app_router.dart)
#### [MODIFY] [screen_body.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/screen_body.dart)
#### [MODIFY] [episode_details_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/screens/episode_details_screen.dart)
- Update code to use `sl<Cubit>()` instead of manual instantiation where applicable.

---

### 3. Code Cleanup & UI Polish
#### [MODIFY] [custom_posters_grid_view.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/widgets/custom_posters_grid_view.dart)
- Remove commented-out code.
#### [MODIFY] [screen_body.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/screen_body.dart)
- Remove `print` statements.
#### [MODIFY] [about_tv_tab_body.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/widgets/tv_widgets/about_tv_tab_body.dart)
- Replace hardcoded strings with localized-ready text and use `AppTextStyles`.

---

### 4. File Management
- Delete any redundant files (e.g., duplicated `home_trending_banner.dart` if it still exists).

## Verification Plan

### Automated Tests
- Run `flutter pub run build_runner build` to verify model generation.
- Ensure the app builds successfully.

### Manual Verification
- Verify that Movie details no longer crash if data is missing.
- Verify that all tabs in the navigation bar work as expected.
- Check that the search functionality still works with the new DI-managed Cubit.
