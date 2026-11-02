import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

import 'watchlist_widgets/watchlist_collection_row.dart';

class WatchlistOptionsSheet extends StatefulWidget {
  final PosterModel? posterModel;

  const WatchlistOptionsSheet({super.key, this.posterModel});

  @override
  State<WatchlistOptionsSheet> createState() => _WatchlistOptionsSheetState();
}

class _WatchlistOptionsSheetState extends State<WatchlistOptionsSheet> {
  final Set<String> _loadingKeys = {};

  Future<void> _toggle(BuildContext context, String key) async {
    if (_loadingKeys.contains(key)) return;

    final libraryCubit = context.read<LibraryCubit>();

    setState(() => _loadingKeys.add(key));

    try {
      await libraryCubit.toggleCollectionItem(
        poster: widget.posterModel!,
        collectionName: key,
      );
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingKeys.remove(key));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          bool isIn(String key) {
            if (widget.posterModel == null) return false;
            return context.read<LibraryCubit>().isItemInCollection(
              widget.posterModel!,
              key,
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: AppColors.charcoalBlack,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.trueBlack.withValues(alpha: 0.6),
                  blurRadius: 30,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: AppSpacing.only(
                  left: AppSpacing.xl,
                  top: AppSpacing.m,
                  right: AppSpacing.xl,
                  bottom: AppSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: AppColors.slateGray.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    AppSpacing.verticalSpacing(AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Save to Library',
                                style: TextStyles.font17BoldIceBlueMontserrat
                                    .copyWith(
                                      fontSize: 22.sp,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                              AppSpacing.verticalSpacing(AppSpacing.xs),
                              Text(
                                'Organize your cinematic journey',
                                style: TextStyles.font12RegularCoolGrayManrope
                                    .copyWith(
                                      color: AppColors.coolGray.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.coolGray.withValues(alpha: 0.5),
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalSpacing(AppSpacing.xl),
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            WatchlistCollectionRow(
                              activeIcon: Icons.favorite_rounded,
                              inactiveIcon: Icons.favorite_border_rounded,
                              label: 'Favorites',
                              subtitle: 'Your all-time favorites',
                              isSelected: isIn('favorites'),
                              isLoading: _loadingKeys.contains('favorites'),
                              color: AppColors.softRed,
                              onTap: widget.posterModel != null
                                  ? () => _toggle(context, 'favorites')
                                  : null,
                            ),
                            WatchlistCollectionRow(
                              activeIcon: Icons.bookmark_rounded,
                              inactiveIcon: Icons.bookmark_outline_rounded,
                              label: 'To Watch',
                              subtitle: 'Films & shows you plan to watch',
                              isSelected: isIn('toWatch'),
                              isLoading: _loadingKeys.contains('toWatch'),
                              color: AppColors.neonBlue,
                              onTap: widget.posterModel != null
                                  ? () => _toggle(context, 'toWatch')
                                  : null,
                            ),
                            WatchlistCollectionRow(
                              activeIcon: Icons.check_circle_rounded,
                              inactiveIcon: Icons.check_circle_outline_rounded,
                              label: 'Watched',
                              subtitle: 'Already seen it',
                              isSelected: isIn('watched'),
                              isLoading: _loadingKeys.contains('watched'),
                              color: AppColors.tealCyan,
                              onTap: widget.posterModel != null
                                  ? () => _toggle(context, 'watched')
                                  : null,
                            ),
                            WatchlistCollectionRow(
                              activeIcon: Icons.play_circle_fill_rounded,
                              inactiveIcon: Icons.play_circle_outline_rounded,
                              label: 'Watch It Now',
                              subtitle: 'Currently watching',
                              isSelected: isIn('watchNow'),
                              isLoading: _loadingKeys.contains('watchNow'),
                              color: AppColors.amberGold,
                              onTap: widget.posterModel != null
                                  ? () => _toggle(context, 'watchNow')
                                  : null,
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
