import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  static const _tabs = [
    (label: 'Watch Now', icon: Icons.play_circle_outline_rounded),
    (label: 'To Watch', icon: Icons.bookmark_outline_rounded),
    (label: 'Watched', icon: Icons.check_circle_outline_rounded),
    (label: 'Favorites', icon: Icons.favorite_border_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    // Keep TabBar and PageView in sync without duplicate listeners
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _tabController.index,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        appBar: AppBar(
          backgroundColor: AppColors.richEerieBlack,
          elevation: 0,
          titleSpacing: 20.w,
          title: Text(
            'My Library',
            style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
              fontSize: 22.sp,
              letterSpacing: 0.5,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            unselectedLabelStyle: TextStyles.font10MediumCoolGraySora.copyWith(
              fontWeight: Weights.bold,
              fontSize: 13.sp,
            ),
            labelStyle: TextStyles.font13BoldNeonBlueSora,
            indicatorColor: AppColors.neonBlue,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.neonBlue,
            unselectedLabelColor: AppColors.slateGray,
            padding: AppSpacing.horizontal(5),
            tabs: _tabs
                .map((t) => Tab(text: t.label))
                .toList(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<LibraryCubit, LibraryState>(
            builder: (context, state) {
              if (state is LibraryLoading || state is LibraryInitial) {
                return const Center(child: MovuraLoadingIndicator());
              }

              if (state is LibraryError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyles.font12RegularCoolGrayManrope,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final userModel = state is LibraryLoaded ? state.userModel : null;

              return PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  // Sync tab without triggering _onTabChanged listener
                  _tabController.animateTo(
                    index,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                  );
                },
                children: [
                  _LibraryTabContent(
                    title: 'Watch It Now',
                    emptyIcon: Icons.play_circle_outline_rounded,
                    items: userModel?.watchNow ?? [],
                  ),
                  _LibraryTabContent(
                    title: 'To Watch',
                    emptyIcon: Icons.bookmark_outline_rounded,
                    items: userModel?.toWatch ?? [],
                  ),
                  _LibraryTabContent(
                    title: 'Watched',
                    emptyIcon: Icons.check_circle_outline_rounded,
                    items: userModel?.watched ?? [],
                  ),
                  _LibraryTabContent(
                    title: 'Favorites',
                    emptyIcon: Icons.favorite_border_rounded,
                    items: userModel?.favorites ?? [],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LibraryTabContent extends StatelessWidget {
  const _LibraryTabContent({
    required this.title,
    required this.emptyIcon,
    required this.items,
  });

  final String title;
  final IconData emptyIcon;
  final List<PosterModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyState(title: title, icon: emptyIcon);
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppSpacing.all(AppSpacing.l),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PosterCard(
          mediaModel: item,
          mediaType: item.mediaType,
          elevation: 6,
          width: double.infinity,
          height: double.infinity,
          border: 12,
          titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(
            fontSize: 11.sp,
            fontWeight: Weights.extraBold,
          ),
          subTextStyle: TextStyles.font16SemiBoldPlatinumGray.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
          ),
          showMediaType: true,
          maxLines: 2,
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onyxBlack.withValues(alpha: 0.5),
                border: Border.all(
                  color: AppColors.slateGray.withValues(alpha: 0.1),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                size: 40.sp,
                color: AppColors.slateGray.withValues(alpha: 0.4),
              ),
            ),
            AppSpacing.verticalSpacing(AppSpacing.xl),
            Text(
              'Nothing in $title yet',
              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                color: AppColors.slateGray,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSpacing(AppSpacing.s),
            Text(
              'Browse movies and shows, then tap the bookmark icon to add them here.',
              textAlign: TextAlign.center,
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.6),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
