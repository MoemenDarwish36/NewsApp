import 'package:flutter/material.dart';

import '../../../../model/NewsResponse.dart';
import '../../../utilites/api_manger.dart';
import '../../../utilites/app_colors.dart';
import '../news/news_item.dart';

class NewsSearchDelegate extends SearchDelegate {
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
    if (query.isNotEmpty) {
      return FutureBuilder<NewsResponse?>(
          future: ApiManager.getNewsBySourceId(query: query),
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
                        ApiManager.getNewsBySourceId(query: query);
                      },
                      child: Text("Try Again",
                          style: Theme.of(context).textTheme.titleSmall))
                ],
              );
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
                        ApiManager.getNewsBySourceId(query: query);
                      },
                      child: Text(
                        "Try Again",
                        style: Theme.of(context).textTheme.titleSmall,
                      ))
                ],
              );
            }
            var newsList = snapShot.data!.articles!;
            return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: newsList[index]);
                });
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
