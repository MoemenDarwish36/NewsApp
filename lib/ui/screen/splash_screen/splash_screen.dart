import 'package:flutter/material.dart';

import '../../utilites/app_assets.dart';
import '../home_screen/home_screen.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    // themeProvider = Provider.of(context);
    return Scaffold(
        body:
            // themeProvider.isDarkThemeEnabled
            //     ? Image.asset(AppAssets.splashDark)
            //     :

            Image.asset(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
                AppAssets.splashLight));
  }
}
