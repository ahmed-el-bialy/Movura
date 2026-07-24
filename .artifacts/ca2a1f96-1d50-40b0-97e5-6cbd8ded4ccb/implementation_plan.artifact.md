# Implementation Plan - Final Professional Polish and Firebase Integration

This plan addresses a complete routing review, upgrading the Video Screen for the latest library, redesigning the Home categories, and finalizing Firebase Auth integration.

## User Review Required

> [!IMPORTANT]
> - **Video Screen Redesign**: I will refactor `VideoScreen` to use `YoutubePlayerBuilder`, which is the standard for `youtube_player_flutter` v10+. This will provide a more stable full-screen and control experience.
> - **Home Section Changes**: I will **delete** the `HomeTrendingBanner` as requested and completely redesign the `CategoryList` as a modern, horizontally scrollable list.
> - **Firebase Auth**: I will ensure the Login and Signup logic is fully connected to the Firebase backend, including error handling (e.g., showing SnackBars for wrong credentials).

## Proposed Changes

### 1. Routing & UX Consistency
#### [MODIFY] [app_router.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/core/routing/app_router.dart)
- Review and clean up all route definitions.
- Ensure the transition between Login -> MainWrapper is smooth.

---

### 2. Video Player Upgrade (v10.0.1)
#### [MODIFY] [video_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/details/ui/screens/video_screen.dart)
- Refactor to use `YoutubePlayerBuilder` for automatic orientation handling.
- Improve the UI of overlays and the custom back button in landscape mode.

---

### 3. Home Screen Redesign
#### [DELETE] [home_trending_banner.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/ui/widgets/sub_widgets/home_trending_banner.dart)
- Remove the banner widget and all its references in `HomeScreen`.

#### [MODIFY] [category_list.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/home/ui/widgets/category_list.dart)
- Redesign from scratch as a horizontal `ListView` of compact, modern cards.
- Add better visual feedback and styling consistent with the app's theme.

---

### 4. Auth Completion & Firebase Logic
#### [MODIFY] [auth_repo.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/auth/data/repos/auth_repo.dart)
#### [MODIFY] [auth_cubit.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/auth/logic/auth/auth_cubit.dart)
- Ensure all methods handle Firebase exceptions (e.g., `user-not-found`, `wrong-password`).
- Finalize the social login structure (placeholders for Google/Facebook/Apple).

#### [MODIFY] [log_in_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/auth/ui/screens/log_in_screen.dart)
#### [MODIFY] [sign_up_screen.dart](file:///home/uzumaki/Development/Flutter /Personal/Movura/lib/features/auth/ui/screens/sign_up_screen.dart)
- Connect the UI buttons to `AuthCubit` logic.
- Add loading indicators (using the already integrated `AuthLoading` state).

## Verification Plan

### Automated Tests
- Run `flutter analyze` to verify the project's health.

### Manual Verification
- Test video playback in both portrait and landscape.
- Verify that `CategoryList` scrolls smoothly and navigates correctly.
- Perform a full Login/Signup flow and check Firebase Console for new users.
