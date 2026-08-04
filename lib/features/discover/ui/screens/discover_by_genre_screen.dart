import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/buttons/app_icon_button.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/components/glass_card.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';

import '../../logic/discover_by_genre_cubit.dart';

class DiscoverByGenreScreen extends StatelessWidget {
  const DiscoverByGenreScreen({super.key, required this.isMovie});

  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DiscoverByGenreCubit>()..getGenres(isMovie),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        appBar: AppBar(
          backgroundColor: AppColors.richEerieBlack,
          elevation: 0,
          centerTitle: true,
          leading: AppIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: () => context.pop(),
          ),
          title: Text(
            isMovie ? "Movie Genres" : "TV Genres",
            style: TextStyles.font20SemiBoldNeonBlueManrope,
          ),
        ),
        body: BlocBuilder<DiscoverByGenreCubit, DiscoverByGenreState>(
          builder: (context, state) {
            if (state is DiscoverByGenreLoading) {
              return const _GenresLoadingPlaceholder();
            } else if (state is DiscoverByGenreLoaded) {
              return _GenresGrid(genres: state.genres, isMovie: isMovie);
            } else if (state is DiscoverByGenreError) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: AppColors.softRed)),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _GenresGrid extends StatelessWidget {
  const _GenresGrid({required this.genres, required this.isMovie});

  final List<GenreModel> genres;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppSpacing.all(AppSpacing.l),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 2.2,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        return InkWell(
          onTap: () {
            context.pushNamed(
              RouteNames.seeAllScreen,
              arguments: SeeAllArguments(
                title: "${genre.name} ${isMovie ? 'Movies' : 'TV Shows'}",
                endpoint: isMovie ? SeeAllEndpoint.moviesByGenre : SeeAllEndpoint.tvByGenre,
                id: genre.id,
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.r),
          child: GlassCard(
            borderRadius: 16.r,
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonBlue.withValues(alpha: 0.1),
                    AppColors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                genre.name,
                style: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: Weights.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GenresLoadingPlaceholder extends StatelessWidget {
  const _GenresLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppSpacing.all(AppSpacing.l),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 2.2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return GlassCard(
          borderRadius: 16.r,
          padding: EdgeInsets.zero,
          color: AppColors.onyxBlack.withValues(alpha: 0.2),
          child: const Center(
            child: MovuraLoadingIndicator(size: 30),
          ),
        );
      },
    );
  }
}
