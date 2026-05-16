import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/home_screen/data/repo/posters_repo.dart';

import '../../features/details_screen/ui/details_screen.dart';
import '../../features/home_screen/logic/main_content/main_content_cubit.dart';
import '../../features/home_screen/ui/main_screen.dart';
import '../helper/constants/strings.dart';
import '../networking/di.dart';

class AppRouter {
  late PostersRepo postersRepo;
  late MainContentCubit contentCubit;

  AppRouter() {
    postersRepo = sl<PostersRepo>();
    contentCubit = MainContentCubit(postersRepo: postersRepo);
  }

  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext context) => contentCubit,
              child: MainScreen(),)
        );
      case Strings.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}
