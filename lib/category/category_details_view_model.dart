import 'package:flutter/material.dart';
import 'package:news_app/model/Sources.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

class CategoryDetailsViewModel extends ChangeNotifier {
  List<Source>? sourcesList;

  String? errorMessage;

  void getSources(String categoryId) async {
    sourcesList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response?.status == 'error') {
        errorMessage = response!.message;
      } else {
        sourcesList = response!.sources;
      }
    } catch (e) {
      errorMessage = 'Error Loading Source List';
    }
    notifyListeners();
  }
}
