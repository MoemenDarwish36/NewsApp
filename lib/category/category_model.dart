import 'package:flutter/material.dart';
import 'package:news_app/ui/utilites/app_assets.dart';
import 'package:news_app/ui/utilites/app_colors.dart';
import 'package:news_app/ui/utilites/localization_extension.dart';

class CategoryModel {
  String id;

  String imagePass;

  String title;

  Color color;

  CategoryModel(
      {required this.title,
      required this.id,
      required this.color,
      required this.imagePass});

  static List<CategoryModel> getCategories(BuildContext context) {
    return [
      CategoryModel(
          title: context.localization.sports,
          id: 'sports',
          color: AppColors.redColor,
          imagePass: AppAssets.sport),
      CategoryModel(
          title: context.localization.general,
          id: 'general',
          color: AppColors.darkBlueColor,
          imagePass: AppAssets.general),
      CategoryModel(
          title: context.localization.health,
          id: 'health',
          color: AppColors.pinkColor,
          imagePass: AppAssets.health),
      CategoryModel(
          title: context.localization.business,
          id: 'business',
          color: AppColors.brownColor,
          imagePass: AppAssets.business),
      CategoryModel(
          title: context.localization.entertainment,
          id: 'entertainment',
          color: AppColors.blueColor,
          imagePass: AppAssets.entertainment),
      CategoryModel(
          title: context.localization.science,
          id: 'science',
          color: AppColors.yellowColor,
          imagePass: AppAssets.science),
      CategoryModel(
          title: context.localization.technology,
          id: 'technology',
          color: AppColors.darkBlueColor,
          imagePass: AppAssets.technology),
    ];
  }
}
