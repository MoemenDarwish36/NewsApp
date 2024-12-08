import '../../model/NewsResponse.dart';

abstract class NewsRepositoryContract {
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query});
}
