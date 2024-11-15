import 'package:flutter/material.dart';
import 'package:news_app/ui/utilites/app_colors.dart';
import 'package:news_app/ui/utilites/localization_extension.dart';

class HomeDrawer extends StatelessWidget {
  Function onSideMenuItemClick;

  static const int categories = 1;

  static const int settings = 2;

  HomeDrawer({super.key, required this.onSideMenuItemClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .08),
          color: AppColors.primaryLightColor,
          child: Text(
            'News App!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              onSideMenuItemClick(categories);
            },
            child: Row(
              children: [
                const Icon(Icons.list),
                const SizedBox(
                  width: 10,
                ),
                Text(context.localization.categories,
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              onSideMenuItemClick(settings);
            },
            child: Row(
              children: [
                const Icon(Icons.settings),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  context.localization.settings,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
