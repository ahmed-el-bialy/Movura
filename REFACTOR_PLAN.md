REFACTOR_PLAN — Inline TextStyle Consolidation

Status: Draft — automated audit found a small number of inline TextStyle usages to consolidate into `lib/core/theming/text_styles.dart` or to create a new named TextStyle entry there.

Goal
- Remove inline TextStyle(...) usages where they duplicate or slightly vary existing TextStyles.
- Where a new visual variant is required, add a named TextStyle to `text_styles.dart` following existing naming patterns (font{Size}{Weight}{Color}{FontFamily}).
- Apply changes in small, one-file commits to keep diffs reviewable.

Guidelines
- Prefer existing TextStyles when a close match exists (use copyWith to tweak small values like fontSize or color alpha).
- For repeated copyWith patterns, add a new named TextStyle in `text_styles.dart` (follow local naming style: e.g., font14SimiBoldPlatinumGraySora).
- Use ScreenUtil (.sp) for font sizes where needed — prefer to apply `.copyWith(fontSize: xx.sp)` in-call sites rather than creating many near-duplicate base styles.
- Keep commit messages with Conventional Commits: e.g., `refactor(style): replace inline TextStyle in tv_identify_card`.

Files identified (from grep)
1. lib/features/tv_details/ui/widgets/tv_info_widgets/tv_identify_card.dart
   - Inline TextStyle(...) around labels. Recommend replace with TextStyles.font14SimiBoldPlatinumGraySora or similar.
   - Priority: High — repeated across TV details screens. Effort: Low. Risk: Low.

2. lib/features/tv_details/ui/widgets/about_tv_tab_body.dart
   - Inline TextStyle in several text spans. Recommend reuse of existing styles or add small variant.
   - Priority: Medium. Effort: Low. Risk: Low.

3. lib/features/movie_details/ui/widgets/movie_info_widgets/movie_identify_card.dart
   - Inline TextStyle similar to tv_identify_card. Use existing Movie detail styles.
   - Priority: High. Effort: Low. Risk: Low.

4. lib/features/see_all/ui/widgets/see_all_grid.dart
   - Inline TextStyle usage (color: AppColors.softRed, fontSize:16.sp). Consider `TextStyles.font16SimiBold...` or using an existing style + copyWith color.
   - Priority: Low. Effort: Low. Risk: Low.

5. lib/core/widgets/shared_details/platform_options_sheet.dart
   - Inline TextStyle used in sheet buttons. Replace with appropriate `TextStyles` entry or `TextStyles.font14PureWhiteManrope.copyWith(...)`.
   - Priority: Low. Effort: Low. Risk: Low.

6. lib/core/widgets/shared_details/core_details_header.dart (review suggestion)
   - Check for inline styles and replace where present.

Action plan (atomic tasks)
- task 1 (refactor/style-text-tv-identify): Replace inline TextStyle in tv_identify_card -> commit
- task 2 (refactor/style-text-movie-identify): Replace inline TextStyle in movie_identify_card -> commit
- task 3 (refactor/style-text-about-tv): Replace inline TextStyle in about_tv_tab_body -> commit
- task 4 (refactor/style-text-see-all): Replace inline TextStyle in see_all_grid -> commit
- task 5 (refactor/style-text-platform-sheet): Replace inline TextStyle in platform_options_sheet -> commit

Each task will:
- Add or reuse named TextStyle from `text_styles.dart` when appropriate.
- Run `flutter analyze` (if available) and ensure project builds locally before committing.
- Commit with a clear message and keep the change limited to the single file.

Notes
- Many files already use TextStyles from `text_styles.dart`. These tasks are low-risk and keep the visual identity consistent.
- After these replacements, run a visual review to ensure no unintended visual regressions (font sizes and colors preserved).


