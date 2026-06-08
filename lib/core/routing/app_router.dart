import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details_screen/data/repos/tv_repos/about_tv_series_repo.dart';
import 'package:movura/features/details_screen/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/tv_series_details_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../features/details_screen/data/repos/movie_repos/about_repo.dart';
import '../../features/details_screen/logic/movie_screen_cubit/main_details/about_cubit.dart';
import '../../features/details_screen/ui/arguments_model.dart';
import '../../features/details_screen/ui/screens/moive_details_screen/widgets/main_screen/movie_details_screen.dart';
import '../../features/home_screen/data/repo/trending_content_repo.dart';
import '../../features/home_screen/logic/main_content/main_content_cubit.dart';
import '../../features/home_screen/ui/main_screen.dart';
import '../../features/details_screen/ui/screens/shared/screens/video_screen.dart';
import '../networking/di.dart';
import '../utils/constants/strings.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MainContentCubit(postersRepo: sl<TrendingContentRepo>())
                  ..getTrendingPosters(),
            child: const MainScreen(),
          ),
        );

      case Strings.detailsScreen:
        final arguments = setting.arguments as ArgumentsModel;

        if (arguments.mediaType == "movie") {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  AboutCubit(repo: sl<AboutRepo>())
                    ..getMovieMainDetails(id: arguments.mediaId),
              child: MovieDetailsScreen(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  AboutTvCubit(repo: sl<AboutTvSeriesRepo>())
                    ..getTvSeriesMainDetails(id: arguments.mediaId),
              child: TvSeriesDetailsScreen(),
            ),
          );
        }

      case Strings.videoPlayScreen:
        final controller = setting.arguments as YoutubePlayerController;
        return MaterialPageRoute(
          builder: (_) => VideoScreen(controller: controller),
        );
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
