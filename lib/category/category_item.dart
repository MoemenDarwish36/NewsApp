import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;

  int index;

  CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: Radius.circular(index % 2 == 0 ? 25 : 0),
            bottomRight: Radius.circular(index % 2 == 0 ? 0 : 25),
          )),
      child: Column(
        children: [
          Image.asset(
              height: MediaQuery.of(context).size.height * .15,
              category.imagePass),
          Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
