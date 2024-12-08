import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_data_source.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) {
    return remoteDataSource.getNewsBySourceId(
        sourceId: sourceId, page: page, pageSize: pageSize, query: query);
  }
}
