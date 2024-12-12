import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/ui/utilites/api_constants.dart';

//500c5a4f9b244f3db92a47f436f1819e
//7ddcd4e71f2849a38b3fb1f3818b3094
@singleton
class ApiManager {
  // ApiManager._();
  //
  // static ApiManager? _instance;
  //
  // static ApiManager getInstance() {
  //   _instance ??= ApiManager._();
  //   return _instance!;
  // }

  Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
      'q': query
    });

    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

}
