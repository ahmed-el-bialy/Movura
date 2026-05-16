import 'package:flutter/material.dart';

import '../../features/details_screen/ui/details_screen.dart';
import '../../features/home_screen/ui/main_screen.dart';
import '../helper/constants/strings.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case Strings.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}
