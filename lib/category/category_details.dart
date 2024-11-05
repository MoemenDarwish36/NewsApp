import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';

import '../model/SourceResponse.dart';
import '../ui/screen/home_screen/tabs/tab_widget.dart';
import '../ui/utilites/api_manger.dart';
import '../ui/utilites/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  CategoryModel category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(widget.category.id),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else if (snapShot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Some thing went wrong",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      ApiManager.getSources(widget.category.id);
                      setState(() {});
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );

            /// server response
            /// error
          }
          if (snapShot.data!.status != 'ok') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(snapShot.data!.message!,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      ApiManager.getSources(widget.category.id);
                      setState(() {});
                    },
                    child: Text(
                      "Try Again",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            );
          }

          /// success
          var sourceList = snapShot.data!.sources!;
          return TabWidget(sourceList: sourceList);
        });
  }
}
