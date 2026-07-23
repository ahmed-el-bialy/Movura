import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/widgets/back_to_home_scope.dart';
import 'package:movura/features/auth/ui/screens/log_in_screen.dart';
import 'package:movura/features/auth/ui/screens/sign_up_screen.dart';
import 'package:movura/features/details/data/repos/tv_series_repo.dart';
import 'package:movura/features/details/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import 'package:movura/features/details/logic/tv_series_cubit/tv_seasons_cubit/tv_seasons_cubit.dart';
import 'package:movura/features/details/ui/screens/all_seasons_screen.dart';
import 'package:movura/features/details/ui/screens/season_details_screen.dart';
import 'package:movura/features/details/ui/screens/tv_series_details_screen.dart';
import 'package:movura/features/trending_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../features/details/data/repos/movies_repo.dart';
import '../../features/details/logic/movie_screen_cubit/main_details/about_cubit.dart';
import '../../features/details/ui/screens/movie_details_screen.dart';
import '../../features/details/ui/screens/video_screen.dart';
import '../../features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import '../../features/home/logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../../features/home/logic/trending_content/trending_content_cubit.dart';
import '../../features/home/ui/home_screen.dart';
import '../networking/di.dart';
import 'arguments_model.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteNames.logInScreen:
        return MaterialPageRoute(builder: (_) => const LogInScreen());

      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case RouteNames.trendingScreen:
        return MaterialPageRoute(
          builder: (_) => BackToHomeScope(
            child: BlocProvider(
              create: (context) =>
                  sl<TrendingContentCubit>()..getTrendingPosters(),
              child: const TrendingScreen(),
            ),
          ),
        );

      case RouteNames.mainScreen:
        return MaterialPageRoute(
          builder: (_) => HomeRootScope(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      sl<TrendingContentCubit>()..getTrendingPosters(),
                ),
                BlocProvider(
                  create: (context) =>
                      sl<TopRatedMovieCubit>()..getTopRatedMovies(),
                ),
                BlocProvider(
                  create: (context) =>
                      sl<TopRatedTvSeriesCubit>()..getTopRatedTvSeries(),
                ),
              ],
              child: const HomeScreen(),
            ),
          ),
        );

      case RouteNames.detailsScreen:
        final arguments = setting.arguments as ArgumentsModel;

        if (arguments.mediaType == "movie") {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  AboutCubit(repo: sl<MovieRepo>())
                    ..getMovieMainDetails(id: arguments.mediaId),
              child: const MovieDetailsScreen(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  AboutTvCubit(repo: sl<TvSeriesRepo>())
                    ..getTvSeriesMainDetails(id: arguments.mediaId),
              child: const TvSeriesDetailsScreen(),
            ),
          );
        }

      case RouteNames.seasonDetailsScreen:
        final arguments = setting.arguments as SeasonArgumentsModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TvSeasonsCubit(repo: sl<TvSeriesRepo>())
              ..getTvSeasonDetails(
                tvId: arguments.tvId,
                seasonNumber: arguments.seasonNumber,
              ),
            child: SeasonDetailsScreen(arguments: arguments),
          ),
        );

      case RouteNames.allSeasonsScreen:
        final arguments = setting.arguments as AllSeasonsArgumentsModel;
        return MaterialPageRoute(
          builder: (_) => AllSeasonsScreen(arguments: arguments),
        );

      case RouteNames.videoPlayScreen:
        final controller = setting.arguments as YoutubePlayerController;
        return MaterialPageRoute(
          builder: (_) => VideoScreen(controller: controller),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => HomeRootScope(child: const HomeScreen()),
        );
    }
  }
}
