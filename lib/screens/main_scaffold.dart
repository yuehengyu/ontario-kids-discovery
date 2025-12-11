import 'package:flutter/material.dart';
import 'home_screen.dart';
// 如果您建了其他文件，把下面注释打开
import 'play_screen.dart';
import 'learn_screen.dart';
import 'eat_screen.dart';
import 'family_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0; // 当前选中的 Tab 索引

  // 页面列表
  final List<Widget> _screens = [
    const HomeScreen(),       // 对应 home_screen.dart
    const PlayScreen(),       // 对应 play_screen.dart (刚才写的地图页)
    const LearnScreen(),      // <--- 对应 learn_screen.dart (修好后就不报错了)
    const EatScreen(),        // <--- 对应 eat_screen.dart (如果还没建，就先用 Center(Text...))
    const FamilyScreen(),     // <--- 对应 family_screen.dart
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶栏：暂时写死，后面换成“定位胶囊”
      appBar: AppBar(
        title: const Text('Ontario Kids Discovery'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),

      // 核心内容区：显示当前选中的页面
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // 底部导航栏
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Play'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.restaurant_outlined), selectedIcon: Icon(Icons.restaurant), label: 'Eat'),
          NavigationDestination(icon: Icon(Icons.people_outlined), selectedIcon: Icon(Icons.people), label: 'Family'),
        ],
      ),
    );
  }
}