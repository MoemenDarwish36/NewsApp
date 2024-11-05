import 'package:flutter/material.dart';
import 'package:news_app/category/category_details.dart';
import 'package:news_app/category/category_fragment.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/ui/screen/home_screen/drawer/home_drawer.dart';
import 'package:news_app/ui/screen/home_screen/settings/settings_tab.dart';
import 'package:news_app/ui/utilites/app_assets.dart';
import 'package:news_app/ui/utilites/app_colors.dart';
import 'package:news_app/ui/utilites/localization_extension.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
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
                selectSideMenuItem == HomeDrawer.settings
                    ? context.localization.settings
                    : selectedCategory == null
                        ? 'News App!'
                        : selectedCategory!.id,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            drawer: Drawer(
              child: HomeDrawer(
                onSideMenuItemClick: onSideMenuItemClick,
              ),
            ),
            body: selectSideMenuItem == HomeDrawer.settings
                ? SettingsTab()
                : selectedCategory == null
                    ? CategoryFragment(
                        onCategoryItemClick: onCategoryItemClick,
                      )
                    : CategoryDetails(
                        category: selectedCategory!,
                      ),
          )
        ],
      ),
    );
  }

  CategoryModel? selectedCategory;

  onCategoryItemClick(CategoryModel newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }

  int selectSideMenuItem = HomeDrawer.categories;

  onSideMenuItemClick(int newSideMenuItem) {
    selectSideMenuItem = newSideMenuItem;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
