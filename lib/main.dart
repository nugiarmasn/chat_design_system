import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'layouts/main_layout.dart'; // Import layout yang baru dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0052CC)),
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}