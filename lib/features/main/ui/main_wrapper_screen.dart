import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/features/categories/ui/screens/categories_screen.dart';
import 'package:movura/features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movura/features/home/logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:movura/features/home/logic/trending_content/trending_content_cubit.dart';
import 'package:movura/features/home/ui/home_screen.dart';
import 'package:movura/features/profile/ui/screens/profile_screen.dart';
import 'package:movura/features/search/ui/screens/search_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CategoriesScreen(),
    const ProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TrendingContentCubit>()..getTrendingPosters(),
        ),
        BlocProvider(
          create: (context) => sl<TopRatedMovieCubit>()..getTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => sl<TopRatedTvSeriesCubit>()..getTopRatedTvSeries(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: AppNavigationBar(
          activeIndex: _currentIndex,
          onTabChanged: _onTabChanged,
        ),
      ),
    );
  }
}
