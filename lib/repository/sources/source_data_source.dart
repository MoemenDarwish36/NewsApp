import '../../model/SourceResponse.dart';

abstract class SourceRemoteDataSource {
  Future<SourceResponse?> getSources(String categoryId);
}

abstract class SourceLocalDataSource {
  Future<SourceResponse?> getSources(String categoryId);

  void saveSources(SourceResponse? sourceResponse, String category);
}
