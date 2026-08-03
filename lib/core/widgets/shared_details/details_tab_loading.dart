import 'package:flutter/material.dart';
import 'package:movura/core/widgets/movura_loading_indicator.dart';

import '../../helpers/spacing.dart';

class DetailsTabLoading extends StatelessWidget {
  const DetailsTabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacing(80),
        const Center(
          child: MovuraLoadingIndicator(
            size: 100,
          ),
        ),
        verticalSpacing(100),
      ],
    );
  }
}
