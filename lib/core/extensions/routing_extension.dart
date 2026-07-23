import 'package:flutter/cupertino.dart';

import '../routing/route_names.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, Object? arguments) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil({
    required String routeName,
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, Object? arguments) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();

  Future<void> goHome() {
    return pushAndRemoveUntil(
      routeName: RouteNames.mainScreen,
      predicate: (_) => false,
    );
  }

  void popToHomeOrGoHome() {
    final navigator = Navigator.of(this);
    var foundHome = false;

    navigator.popUntil((route) {
      if (route.settings.name == RouteNames.mainScreen) {
        foundHome = true;
        return true;
      }
      return route.isFirst;
    });

    if (!foundHome) {
      goHome();
    }
  }

  bool get isOnHomeScreen {
    return ModalRoute.of(this)?.settings.name == RouteNames.mainScreen;
  }
}
