import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/repository/news/data_sources/news_local_data_source_impl.dart';
import 'package:news_app/repository/news/data_sources/news_remote_data_source_impl.dart';
import 'package:news_app/repository/news/news_data_source.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';

import '../../../../utilites/api_manger.dart';

class NewsDetailsViewModel extends Cubit<NewsState> {
  late NewsRepositoryContract repositoryContract;

  late NewsRemoteDataSource remoteDataSource;

  late ApiManager apiManager;
  late NewsLocalDataSource localDataSource;

  NewsDetailsViewModel() : super(NewsLoadingState()) {
    apiManager = ApiManager();
    remoteDataSource = NewsRemoteDataSourceImpl(apiManager: apiManager);
    localDataSource = NewsLocalDataSourceImpl();
    repositoryContract = NewsRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
  }

  void getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize, String? query}) async {
    try {
      emit(NewsLoadingState());
      var response = await repositoryContract.getNewsBySourceId(
          sourceId: sourceId, page: page, pageSize: pageSize, query: query);
      if (response?.status == 'error') {
        emit(NewsErrorState(errorMessage: response!.message!));
        return;
      }
      if (response?.status == 'ok') {
        emit(NewsSuccessState(newsList: response!.articles!));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }

  int selectedIndex = 0;

  void updateSelectedIndex(int index, String sourceId) {
    selectedIndex = index;
    emit(NewsChangeState(sourceId: sourceId));
  }
}
