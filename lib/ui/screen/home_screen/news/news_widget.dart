import 'package:flutter/material.dart';
import 'package:news_app/model/Articles.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/screen/home_screen/news/news_item.dart';
import 'package:news_app/ui/screen/home_screen/news/news_widget_view_model.dart';
import 'package:news_app/ui/utilites/api_manger.dart';
import 'package:provider/provider.dart';

import '../../../utilites/app_colors.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  int page = 1;

  int pageSize = 10;

  ScrollController scrollController = ScrollController();

  List<News> newsList = [];
  NewsWidgetViewModel viewModel = NewsWidgetViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id ?? '', page);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset != 0 &&
            scrollController.position.pixels != 0) {
          page++;
          loadMoreNews();
        }
      }
    });
  }

  Future<void> loadMoreNews() async {
    NewsResponse? response = await ApiManager.getNewsBySourceId(
        sourceId: widget.source.id ?? '', page: page++, pageSize: pageSize);
    newsList.addAll(response?.articles ?? []);

    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child:
            Consumer<NewsWidgetViewModel>(builder: (context, viewModel, child) {
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
                      viewModel.getNewsBySourceId(widget.source.id ?? '', page);
                      setState(() {});
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          }
          if (viewModel.newsList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else {
            return ListView.builder(
                controller: scrollController,
                itemCount: viewModel.newsList!.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: viewModel.newsList![index]);
                });
          }
        }));
  }
}
