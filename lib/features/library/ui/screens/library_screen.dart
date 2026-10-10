import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';
import 'package:movura/features/library/ui/widgets/library_tab_content.dart';

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
            tabs: _tabs.map((t) => Tab(text: t.label)).toList(),
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
                  _tabController.animateTo(
                    index,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                  );
                },
                children: [
                  LibraryTabContent(
                    title: 'Watch It Now',
                    emptyIcon: Icons.play_circle_outline_rounded,
                    items: userModel?.watchNow ?? [],
                  ),
                  LibraryTabContent(
                    title: 'To Watch',
                    emptyIcon: Icons.bookmark_outline_rounded,
                    items: userModel?.toWatch ?? [],
                  ),
                  LibraryTabContent(
                    title: 'Watched',
                    emptyIcon: Icons.check_circle_outline_rounded,
                    items: userModel?.watched ?? [],
                  ),
                  LibraryTabContent(
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
