import 'package:flutter/material.dart';
import 'package:ontario_kids_discovery/screens/eat_screen.dart';
import 'package:ontario_kids_discovery/screens/family_screen.dart';
import 'package:ontario_kids_discovery/screens/learn_screen.dart';
import 'home_screen.dart';
import 'play_screen.dart'; // 确保引用了 PlayScreen
// import 'learn_screen.dart'; // 还没写新版，先注释或保持原样
// import 'eat_screen.dart';
// import 'family_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PlayScreen(),
    // 临时占位，防止报错，等你写好 LearnScreen 再换回来
    const LearnScreen(),
    const EatScreen(),
    const FamilyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ❌ 彻底删除了 appBar: ... 这一大块
      // 让每个页面 (Home, Play) 自己去控制顶部区域

      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: Colors.white, // 底部设为白色，更干净
        indicatorColor: const Color(0xFFFFE0B2), // 选中时的浅橙色背景
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Color(0xFFE67E22)),
              label: 'Home'
          ),
          NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map, color: Color(0xFFE67E22)),
              label: 'Play'
          ),
          NavigationDestination(icon: Icon(Icons.school_outlined), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.restaurant_outlined), label: 'Eat'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}