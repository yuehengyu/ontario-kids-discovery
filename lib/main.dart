import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/main_scaffold.dart';

// ⚠️ 别忘了把您的 Key 填回来！
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange), // 暖色调主题
        useMaterial3: true,
      ),
      // 指向我们刚才写的骨架页
      home: const MainScaffold(),
    );
  }
}