# Implementation Plan - Professional Navigation, UI Redesign, and Architecture Refinement

This plan aims to transform the app into a high-end, professional product by implementing persistent navigation, a modern Home UI, and a cleaner project structure.

## User Review Required

> [!IMPORTANT]
> - **Stateful Navigation**: I will implement a `MainWrapperScreen` using an `IndexedStack` to keep the Home, Search, Categories, and Profile pages in memory. This prevents unnecessary API re-requests when switching tabs.
> - **Trending Banners**: The top cards on the Home screen will be replaced with a high-end "Movie Poster Banner" using `PageView` and glassmorphism effects.
> - **Sub-Widget Restructuring**: I will move local widgets into `sub_widgets` directories to keep the main `widgets` folders clean.

## Proposed Changes

### 1. Navigation & Routing (Stateful/Persistent)

#### [NEW] [main_wrapper_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/main_wrapper_screen.dart)
- Create a root screen that manages the `AppNavigationBar` and an `IndexedStack` for the 4 main tabs.
- Tab 1: Home
- Tab 2: Search (Integrated as a full screen or persistent delegate)
- Tab 3: Categories
- Tab 4: Profile

#### [MODIFY] [app_router.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/routing/app_router.dart)
- Update `mainScreen` route to point to `MainWrapperScreen`.

---

### 2. Home UI - Trending Banners (Redesign from Scratch)

#### [NEW] [home_trending_banner.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/ui/widgets/sub_widgets/home_trending_banner.dart)
- A professional, auto-playing (optional) banner using `PageView`.
- Features: Stacked gradients, high-quality image background, and glassmorphism info cards.

---

### 3. Architecture & Refactoring (Sub-Widgets)

#### [MODIFY] Directory Structure
- Create `sub_widgets` folders in:
  - `lib/features/home/ui/widgets/`
  - `lib/features/search/ui/widgets/`
  - `lib/features/details/ui/widgets/tv_widgets/`
- Move specific, non-reusable sub-components into these folders.

---

### 4. Search & Auth UI Tweaks

#### [MODIFY] [custom_search_delegate.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/search/ui/custom_search_delegate.dart)
- Fix text visibility issues (White/IceBlue text on dark bg).

#### [MODIFY] [log_in_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/auth/ui/screens/log_in_screen.dart)
- Professional cleanup (Gradients, better shadow handling).

## Verification Plan

### Automated Tests
- Run `flutter pub run build_runner build` to ensure all models are up to date.

### Manual Verification
- Switch between tabs and verify that the Home screen does **not** show a loading indicator (state is preserved).
- Verify the new Trending Banner animations and responsiveness.
- Ensure the Search input text is clearly visible.
