import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import '../../logic/discover_people_cubit.dart';
import '../widgets/discover_screen_template.dart';

import '../../data/repo/discover_repo.dart';

class DiscoverPeopleScreen extends StatelessWidget {
  const DiscoverPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DiscoverPeopleCubit>()..getDiscoverPeople(),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        body: BlocBuilder<DiscoverPeopleCubit, DiscoverPeopleState>(
          builder: (context, state) {
            if (state is DiscoverPeopleLoading) {
              return const Center(child: MovuraLoadingIndicator());
            } else if (state is DiscoverPeopleLoaded) {
              return _buildContent(context, state);
            } else if (state is DiscoverPeopleError) {
              return AppErrorWidget(
                errorMessage: state.message,
                onRetry: () => context.read<DiscoverPeopleCubit>().getDiscoverPeople(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiscoverPeopleLoaded state) {
    final discoverRepo = sl<DiscoverRepo>();

    final sections = [
      DiscoverSectionData(
        title: 'Trending Today',
        items: state.trendingDay,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Trending People",
          (page) => discoverRepo.getTrendingPeople("day", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'Popular People',
        items: state.popular,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Popular People",
          (page) => discoverRepo.getPopularPeople(page: page),
        ),
      ),
    ];

    return DiscoverScreenTemplate(
      title: "People",
      featuredPosters: state.popular.take(5).toList(),
      horizontalSections: sections,
      categories: const [],
    );
  }

  void _navigateToSeeAll(
    BuildContext context,
    String title,
    Future<List<PosterModel>> Function(int page) fetchData,
  ) {
    context.pushNamed(
      RouteNames.seeAllScreen,
      arguments: SeeAllArguments(title: title, fetchData: fetchData),
    );
  }
}
