import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

class ApiManager {
  static const String _apiKey = "7ddcd4e71f2849a38b3fb1f3818b3094";

  static const String _baseUrl = "newsapi.org";

  static const String _sourcesEndPoint = "/v2/top-headlines/sources";

  static const String _newsEndPoint = "/v2/everything";

  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(_baseUrl, _sourcesEndPoint, {
      'apiKey': _apiKey,
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

  static Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize}) async {
    Uri url = Uri.https(_baseUrl, _newsEndPoint, {
      'apiKey': _apiKey,
      'sources': sourceId,
      'pageSize': pageSize.toString(),
      'page': page.toString()
    });

    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsSearchBySourceId(String query) async {
    Uri url =
        Uri.https(_baseUrl, _newsEndPoint, {'apiKey': _apiKey, 'q': query});

    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
