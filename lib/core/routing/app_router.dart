import 'package:flutter/material.dart';
import 'package:movura/features/media/ui/screens/details_screen.dart';
import 'package:movura/features/media/ui/screens/main_screen.dart';

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
