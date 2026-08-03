import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../features/auth/ui/screens/log_in_screen.dart';
import '../../features/auth/ui/screens/sign_up_screen.dart';
import '../../features/discover/ui/screens/discover_movies_screen.dart';
import '../../features/discover/ui/screens/discover_people_screen.dart';
import '../../features/discover/ui/screens/discover_tv_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/home/ui/screens/trending_screen.dart';
import '../../features/library/ui/screens/library_screen.dart';
import '../../features/main/ui/main_wrapper_screen.dart';
import '../../features/movie_details/logic/about/about_cubit.dart';
import '../../features/movie_details/ui/screens/movie_details_screen.dart';
import '../../features/movie_details/ui/screens/video_screen.dart';
import '../../features/person_details/logic/person_details_cubit.dart';
import '../../features/person_details/ui/screens/person_details_screen.dart';
import '../../features/see_all/data/models/see_all_arguments.dart';
import '../../features/see_all/ui/screens/see_all_screen.dart';
import '../../features/tv_details/logic/about/about_tv_cubit.dart';
import '../../features/tv_details/ui/screens/all_seasons_screen.dart';
import '../../features/tv_details/ui/screens/episode_details_screen.dart';
import '../../features/tv_details/ui/screens/tv_details_screen.dart';
import '../../features/tv_details/ui/screens/tv_seasons_screen.dart';
import '../networking/di.dart';
import 'arguments_models.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteNames.logInScreen:
        return MaterialPageRoute(builder: (_) => const LogInScreen());

      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case RouteNames.trendingScreen:
        return MaterialPageRoute(builder: (_) => const TrendingScreen());

      case RouteNames.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainWrapperScreen());

      case RouteNames.libraryScreen:
        return MaterialPageRoute(builder: (_) => const LibraryScreen());

      case RouteNames.detailsScreen:
        final arguments = setting.arguments as DetailsArgumentModel;

        if (arguments.mediaType == "movie") {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  sl<AboutCubit>()..getMovieMainDetails(id: arguments.mediaId),
              child: const MovieDetailsScreen(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  sl<AboutTvCubit>()
                    ..getTvSeriesMainDetails(id: arguments.mediaId),
              child: const TvSeriesDetailsScreen(),
            ),
          );
        }

      case RouteNames.seasonDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const TvSeasonDetailsScreen(),
          settings: setting,
        );

      case RouteNames.episodeDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const EpisodeDetailsScreen(),
          settings: setting,
        );

      case RouteNames.personDetailsScreen:
        final personId = setting.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                sl<PersonDetailsCubit>()..getPersonDetails(id: personId),
            child: const PersonDetailsScreen(),
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

      case RouteNames.seeAllScreen:
        final seeAllArgs = setting.arguments as SeeAllArguments;
        return MaterialPageRoute(
          builder: (_) => SeeAllScreen(arguments: seeAllArgs),
        );

      case RouteNames.discoverMoviesScreen:
        return MaterialPageRoute(builder: (_) => const DiscoverMoviesScreen());

      case RouteNames.discoverTvScreen:
        return MaterialPageRoute(builder: (_) => const DiscoverTvScreen());

      case RouteNames.discoverPeopleScreen:
        return MaterialPageRoute(builder: (_) => const DiscoverPeopleScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
