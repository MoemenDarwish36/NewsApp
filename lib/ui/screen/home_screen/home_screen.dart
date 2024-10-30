import 'package:flutter/material.dart';
import 'package:news_app/ui/utilites/app_assets.dart';
import 'package:news_app/ui/utilites/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              AppAssets.background),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'News App!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        )
      ],
    );
  }
}
//7ddcd4e71f2849a38b3fb1f3818b3094
