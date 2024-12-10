import 'package:hive/hive.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/repository/sources/source_data_source.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('tabs');

    /// Open Box

    var data = SourceResponse.fromJson(box.get(categoryId));

    /// Read Data
    return data;
  }

  @override
  void saveSources(SourceResponse? sourceResponse, String category) async {
    var box = await Hive.openBox('tabs');

    /// Open Box
    await box.put(category, sourceResponse?.toJson());

    /// Write Data (Save)
    await box.close();
  }
}
