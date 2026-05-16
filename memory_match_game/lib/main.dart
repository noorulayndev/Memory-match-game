import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const MemoryMatchGameApp());
}

class MemoryMatchGameApp extends StatelessWidget {
  const MemoryMatchGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Match Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}