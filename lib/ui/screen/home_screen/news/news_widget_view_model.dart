import 'package:flutter/material.dart';
import 'package:news_app/model/Articles.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

class NewsWidgetViewModel extends ChangeNotifier {
  List<News>? newsList;

  String? errorMessage;

  void getNewsBySourceId(String sourceId, int? page) async {
    newsList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response =
          await ApiManager.getNewsBySourceId(sourceId: sourceId, page: page);
      if (response?.status == 'error') {
        errorMessage = response!.message;
      } else {
        newsList = response!.articles;
      }
    } catch (e) {
      errorMessage = 'Error Loading News List.';
    }
    notifyListeners();
  }
}
