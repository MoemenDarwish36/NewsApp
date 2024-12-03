import 'package:news_app/model/Articles.dart';

abstract class NewsState {}

/// parents

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {
  String errorMessage;

  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsState {
  List<News> newsList;

  // final int selectedIndex;

  NewsSuccessState({required this.newsList});
}

class NewsChangeState extends NewsState {
  // int selectedIndex;
  String sourceId;

  NewsChangeState({required this.sourceId});
}