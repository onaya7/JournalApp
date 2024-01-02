import 'package:flutter/material.dart';
import 'package:journalapp/screens/home/home_screen.dart';
import 'package:journalapp/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Persistence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: primary,
        useMaterial3: true,
        bottomAppBarTheme: const BottomAppBarTheme(color: primary),
      ),
      home: const HomeScreen(),
    );
  }
}
