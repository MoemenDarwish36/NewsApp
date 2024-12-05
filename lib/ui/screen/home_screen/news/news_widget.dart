import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_details_view_model.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';

import '../../../utilites/app_colors.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsDetailsViewModel viewModel;

  NewsWidget({super.key, required this.source, required this.viewModel});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  int page = 1;
  int pageSize = 10;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.viewModel
        .getNewsBySourceId(sourceId: widget.source.id ?? '', page: page);
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

  void loadMoreNews() {
    widget.viewModel.getNewsBySourceId(
        sourceId: widget.source.id ?? '', page: page, pageSize: pageSize);
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsDetailsViewModel, NewsState>(
        bloc: widget.viewModel,
        listener: (context, state) {
          if (state is NewsChangeState) {
            widget.viewModel
                .getNewsBySourceId(sourceId: state.sourceId, page: page);
          }
        },
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
                      widget.viewModel.getNewsBySourceId(
                          sourceId: widget.source.id ?? '', page: page);
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
