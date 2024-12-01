import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/Articles.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_details_view_model.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

import '../../../utilites/app_colors.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsDetailsViewModel viewModel = NewsDetailsViewModel();

  int page = 1;
  int pageSize = 10;
  ScrollController scrollController = ScrollController();
  List<News> newsList = [];

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
                      viewModel.getNewsBySourceId(widget.source.id ?? '', page);
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          } else if (state is NewsSuccessState) {
            return ListView.builder(
                controller: scrollController,
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: state.newsList[index]);
                });
          }
          return Container();
        });
  }
}
