import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movura/core/networking/di.dart';
import 'package:movura/core/widgets/navigation/app_navigation_bar.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import '../../home/ui/screens/home_screen.dart';
import '../../library/ui/screens/library_screen.dart';
import '../../profile/ui/screens/profile_screen.dart';
import '../../search/ui/screens/search_screen.dart';

/// Root wrapper — provides LibraryCubit at the top level so that
/// all child screens (WatchlistOptionsSheet, LibraryScreen, ProfileScreen)
/// share the same singleton stream.
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
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // Provide the existing singleton — never close it here
      value: sl<LibraryCubit>(),
      child: PopScope(
        canPop: _currentIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (_currentIndex != 0) {
            setState(() => _currentIndex = 0);
          }
        },
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
      ),
    );
  }
}
