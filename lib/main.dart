import 'package:flutter/material.dart';
import 'package:movie_app/app/bootstrap.dart';

import 'screens/home_screen.dart';

void main() async {
  await bootstrap(() => const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0F0F1E),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
