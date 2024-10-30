import 'package:flutter/material.dart';
import 'package:news_app/ui/screen/home_screen/home_screen.dart';
import 'package:news_app/ui/screen/splash_screen/splash_screen.dart';
import 'package:news_app/ui/utilites/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (_) => const Splash(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
      initialRoute: Splash.routeName,
      theme: AppTheme.lightTheme,


    );
  }
}

