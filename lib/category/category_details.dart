import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/category/category_model.dart';
import 'package:news_app/category/cubit/category_details_view_model.dart';
import 'package:news_app/category/cubit/source_state.dart';
import 'package:news_app/di/di.dart';

import '../ui/screen/home_screen/tabs/tab_widget.dart';
import '../ui/utilites/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  CategoryModel category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = getIt<CategoryDetailsViewModel>();

  /// filled injection

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSource(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsViewModel, SourceState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is SourceLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else if (state is SourceErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(state.errorMessage,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      viewModel.getSource(widget.category.id);
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          } else if (state is SourceSuccessState) {
            return TabWidget(
              sourceList: state.sourceList,
            );
          }
          return Container();
        });
  }
}

