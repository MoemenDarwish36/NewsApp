import 'package:flutter/material.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/utilites/app_colors.dart';

class TabItem extends StatelessWidget {
  bool isSelected;

  Source source;

  TabItem({super.key, required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLightColor : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primaryLightColor, width: 2),
      ),
      child: Text(source.name ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected
                  ? AppColors.whiteColor
                  : AppColors.primaryLightColor)),
    );
  }
}
