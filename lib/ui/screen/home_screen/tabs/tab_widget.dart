import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_details_view_model.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';
import 'package:news_app/ui/screen/home_screen/news/news_widget.dart';
import 'package:news_app/ui/screen/home_screen/tabs/tab_item.dart';

import '../../../../model/Sources.dart';

class TabWidget extends StatelessWidget {
  List<Source> sourceList;

  TabWidget({super.key, required this.sourceList});

  NewsDetailsViewModel viewModel = NewsDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<NewsDetailsViewModel, NewsState>(
        builder: (context, state) {
          return DefaultTabController(
            length: sourceList.length,
            child: Column(
              children: [
                TabBar(
                    onTap: (index) {
                      viewModel.updateSelectedIndex(
                          index, sourceList[index].id ?? '');
                    },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    tabs: sourceList
                        .map((source) => TabItem(
                            isSelected: viewModel.selectedIndex ==
                                sourceList.indexOf(source),
                            source: source))
                        .toList()),
                Expanded(
                    child: BlocProvider.value(
                        value: viewModel,
                        child: NewsWidget(
                          source: sourceList[viewModel.selectedIndex],
                          viewModel: viewModel,
                        )))
              ],
            ),
          );
        },
      ),
    );
  }
}
