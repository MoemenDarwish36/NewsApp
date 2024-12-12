import 'package:injectable/injectable.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/repository/sources/source_data_source.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDataSourceImpl implements SourceRemoteDataSource {
  ApiManager apiManager;

  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var response = await apiManager.getSources(categoryId);
    return response;
  }
}
