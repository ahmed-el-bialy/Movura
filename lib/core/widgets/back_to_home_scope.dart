import 'package:flutter/material.dart';
import 'package:movura/core/extensions/routing_extension.dart';

class HomeRootScope extends StatelessWidget {
  const HomeRootScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: child,
    );
  }
}

class BackToHomeScope extends StatelessWidget {
  const BackToHomeScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.popToHomeOrGoHome();
        }
      },
      child: child,
    );
  }
}
