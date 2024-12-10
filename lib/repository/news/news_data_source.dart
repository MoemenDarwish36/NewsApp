import '../../model/NewsResponse.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query});
}

abstract class NewsLocalDataSource {
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query});

  void saveNews(NewsResponse? newsResponse, String sourceId);
}
