import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/screen/home_screen/news/news_item.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

import '../../../utilites/app_colors.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
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
                      ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      setState(() {});
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
                      ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      setState(() {});
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
  }
}
