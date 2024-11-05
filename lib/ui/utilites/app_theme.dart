import 'package:flutter/material.dart';
import 'package:news_app/ui/utilites/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLightColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryLightColor,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
        titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.greyColor),
      ));
}
