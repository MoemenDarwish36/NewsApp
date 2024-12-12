import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_data_source.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

@Injectable(as: NewsRepositoryContract)
class NewsRepositoryImpl implements NewsRepositoryContract {
  NewsRemoteDataSource remoteDataSource;
  NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      var newsResponse = await remoteDataSource.getNewsBySourceId(
          sourceId: sourceId, page: page, pageSize: pageSize, query: query);
      localDataSource.saveNews(newsResponse, sourceId!);
      return newsResponse;
    } else {
      return localDataSource.getNewsBySourceId(sourceId: sourceId);
    }
  }
}
