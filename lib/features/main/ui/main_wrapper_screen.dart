import 'package:flutter/material.dart';

import '../../../core/widgets/app_navigation_bar.dart';
import '../../home/ui/screens/home_screen.dart';
import '../../library/ui/screens/library_screen.dart';
import '../../profile/ui/screens/profile_screen.dart';
import '../../search/ui/screens/search_screen.dart';

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
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppNavigationBar(
        activeIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
