import 'package:flutter/material.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';

import 'package:movura/core/theming/app_spacing.dart';

class DetailsTabLoading extends StatelessWidget {
  const DetailsTabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalSpacing(80),
        const Center(child: MovuraLoadingIndicator(size: 100)),
        AppSpacing.verticalSpacing(100),
      ],
    );
  }
}
