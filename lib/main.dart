import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/main_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

// ⚠️ 别忘了把你的 Key 填回来！
const supabaseUrl = 'https://vqvbgnufwdmgkvvbtljf.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZxdmJnbnVmd2RtZ2t2dmJ0bGpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNTcwODQsImV4cCI6MjA4MDkzMzA4NH0.UKErzaCkSTpVcxo1oVn8W1Ko7ya82lmGsVyUQ-f3SHU';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const OntarioKidsApp());
}

class OntarioKidsApp extends StatelessWidget {
  const OntarioKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ontario Kids Discovery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // ✨ 核心视觉升级：阳光活力风
        scaffoldBackgroundColor: const Color(0xFFFFFDF5), // 极淡的米黄色背景，护眼温馨
        primaryColor: const Color(0xFFFF9F43), // 活力橙
        // ✨ 新增：使用 Noto Sans 字体 (完美支持中文)
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9F43),
          primary: const Color(0xFFFF9F43),
          secondary: const Color(0xFFFFCB80),
          surface: const Color(0xFFFFFDF5),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFDF5),
          elevation: 0,
          scrolledUnderElevation: 0, // 滚动时不改变颜色
        ),
        fontFamily: 'Round', // 后面我们可以引圆体字，先预留
      ),
      home: const MainScaffold(),
    );
  }
}