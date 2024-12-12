import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_data_source.dart';

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) async {
    var box = await Hive.openBox('tabs');

    /// Open Box

    var data = NewsResponse.fromJson(box.get(sourceId));

    /// Read Data
    return data;
  }

  @override
  void saveNews(NewsResponse? newsResponse, String sourceId) async {
    var box = await Hive.openBox('tabs');

    /// Open Box
    await box.put(sourceId, newsResponse?.toJson());

    /// Write Data (Save)
    await box.close();
  }
}
