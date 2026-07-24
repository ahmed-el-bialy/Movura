# Implementation Plan - Architecture Refinement, Spacing Optimization, and UI Completion

This plan focuses on standardizing the widget architecture, optimizing spacing helpers, and cleaning up the project for a professional finish.

## User Review Required

> [!IMPORTANT]
> - **Spacing Optimization**: I will replace all instances of manual `SliverToBoxAdapter(child: verticalSpacing(x))` with the specialized `sliverVerticalSpacing(x)` helper, and similar for horizontal spacing and manual `SizedBox`.
> - **Widget Refactoring**: I will continue converting helper methods into `StatelessWidget` classes.
> - **Folder Restructuring**: I will finalize moving files to their logical feature folders.

## Proposed Changes

### 1. Spacing Cleanup (Global)
- Search and replace:
  - `SliverToBoxAdapter(child: verticalSpacing(x))` -> `sliverVerticalSpacing(x)`
  - `SliverToBoxAdapter(child: horizontalSpacing(x))` -> `sliverHorizontalSpacing(x)`
  - `SizedBox(height: x.h)` -> `verticalSpacing(x)` (where appropriate)
  - `SizedBox(width: x.w)` -> `horizontalSpacing(x)` (where appropriate)

### 2. Widget Architecture (Refactoring)
- Finish converting methods into `StatelessWidget` classes for all remaining features (Home, Details, Search).

### 3. Folder Structure & Path Correction
- Finalize the move of `trending_screen.dart`, `main_wrapper_screen.dart`, and sub-widgets into their respective `ui/screens/` and `ui/widgets/sub_widgets/` folders.

### 4. Auth UI & Icon Consistency
- Complete the Login/Signup UI.
- Use `AppIconButton` globally for consistent splash and padding.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no broken imports or type errors.

### Manual Verification
- Verify that spacing remains consistent across all screens.
- Ensure state preservation in `MainWrapperScreen` works after restructuring.
