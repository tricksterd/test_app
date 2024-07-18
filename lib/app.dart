import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/book_provider.dart';
import 'package:test_app/screens/home_screen.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BookProvider(),
        child: const MaterialApp(home: HomeScreen()));
  }
}
