import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_details_view_model.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';
import 'package:news_app/ui/screen/home_screen/news/news_widget.dart';
import 'package:news_app/ui/screen/home_screen/tabs/tab_item.dart';

import '../../../../model/Sources.dart';

class TabWidget extends StatefulWidget {
  List<Source> sourceList;

  TabWidget({super.key, required this.sourceList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  NewsDetailsViewModel viewModel = NewsDetailsViewModel();

  // int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<NewsDetailsViewModel, NewsState>(
        builder: (context, state) {
          return DefaultTabController(
            length: widget.sourceList.length,
            child: Column(
              children: [
                TabBar(
                    onTap: (index) {
                      // selectedIndex = index;
                      // setState(() {});
                      viewModel.updateSelectedIndex(
                          index, widget.sourceList[index].id ?? '');
                      // viewModel.getNewsBySourceId(widget.sourceList[selectedIndex].id ?? '' , 1);
                    },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    tabs: widget.sourceList
                        .map((source) => TabItem(
                            isSelected: viewModel.selectedIndex ==
                                widget.sourceList.indexOf(source),
                            source: source))
                        .toList()),
                Expanded(
                    child: BlocProvider.value(
                        value: viewModel,
                        child: NewsWidget(
                          source: widget.sourceList[viewModel.selectedIndex],
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
