import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_data_source.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) async {
    var response = await apiManager.getNewsBySourceId(
        sourceId: sourceId, query: query, pageSize: pageSize, page: page);
    return response;
  }
}
