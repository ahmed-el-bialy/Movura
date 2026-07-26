import 'package:flutter/material.dart';
import 'package:movura/core/widgets/app_navigation_bar.dart';
import 'package:movura/features/home/ui/screens/home_screen.dart';
import 'package:movura/features/library/ui/screens/library_screen.dart';
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
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppNavigationBar(
        activeIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
