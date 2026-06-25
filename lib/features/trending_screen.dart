import 'package:flutter/material.dart';

import '../core/theming/colors.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            title: Text("Trending today"),
            centerTitle: true,
          )
        ],
      ),
    );
  }
}
