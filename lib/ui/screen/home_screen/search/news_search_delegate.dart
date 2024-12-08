import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilites/api_manger.dart';
import '../../../utilites/app_colors.dart';
import '../news/cubit/news_details_view_model.dart';
import '../news/cubit/news_state.dart';
import '../news/news_item.dart';

class NewsSearchDelegate extends SearchDelegate {
  ApiManager apiManager = ApiManager();

  NewsDetailsViewModel viewModel = NewsDetailsViewModel();

  String? lastQuery;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty && query != lastQuery) {
      lastQuery = query;
      viewModel.getNewsBySourceId(query: query);
      print('object0000000000000000000000');
    }
    if (query.isNotEmpty) {
      print("object11111111111111111111111");
      return BlocBuilder<NewsDetailsViewModel, NewsState>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryLightColor,
                ),
              );
            } else if (state is NewsErrorState) {
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
                        viewModel.getNewsBySourceId(query: query);
                      },
                      child: Text("Try Again",
                          style: Theme.of(context).textTheme.titleSmall))
                ],
              );
            } else if (state is NewsSuccessState) {
              return ListView.builder(
                  itemCount: state.newsList.length,
                  itemBuilder: (context, index) {
                    return NewsItem(news: state.newsList[index]);
                  });
            }
            return Container();
          });
    } else {
      return const Center(
        child: Text("Suggestion"),
      );
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide.none)),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryLightColor,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)))),
    );
  }
}
