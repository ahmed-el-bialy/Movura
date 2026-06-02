import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../features/details_screen/data/repos/about_repo.dart';
import '../../features/details_screen/logic/main_details/about_cubit.dart';
import '../../features/details_screen/ui/screens/movie_details_screen.dart';
import '../../features/home_screen/data/repo/posters_repo.dart';
import '../../features/home_screen/logic/main_content/main_content_cubit.dart';
import '../../features/home_screen/ui/main_screen.dart';
import '../../features/shared/screens/video_screen.dart';
import '../networking/di.dart';
import '../utils/constants/strings.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MainContentCubit(postersRepo: sl<PostersRepo>())
                  ..getTrendingPosters(),
            child: const MainScreen(),
          ),
        );

      case Strings.detailsScreen:
        final movieId = setting.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AboutCubit(repo: sl<AboutRepo>())
                  ..getMovieMainDetails(id: movieId),
            child: MovieDetailsScreen(),
          ),
        );

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
