import 'package:flutter/material.dart';
import 'package:news_app/category/category_details_view_model.dart';
import 'package:news_app/category/category_model.dart';
import 'package:provider/provider.dart';

import '../ui/screen/home_screen/tabs/tab_widget.dart';
import '../ui/utilites/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  CategoryModel category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<CategoryDetailsViewModel>(
            builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(viewModel.errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      viewModel.getSources(widget.category.id);
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          } else if (viewModel.sourcesList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else {
            return TabWidget(sourceList: viewModel.sourcesList!);
          }
        }));
  }
}
