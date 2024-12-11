import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/category/cubit/source_state.dart';
import 'package:news_app/repository/sources/data_sources/source_local_data_source_impl.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_data_source_impl.dart';
import 'package:news_app/repository/sources/repository/source_repository_impl.dart';
import 'package:news_app/repository/sources/source_data_source.dart';
import 'package:news_app/repository/sources/source_repository_contract.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

class CategoryDetailsViewModel extends Cubit<SourceState> {
  late SourceRepositoryContract repositoryContract;
  late SourceRemoteDataSource remoteDataSource;
  late ApiManager apiManager;
  late SourceLocalDataSource localDataSource;

  CategoryDetailsViewModel() : super(SourceLoadingState()) {
    apiManager = ApiManager.getInstance();
    remoteDataSource = SourceRemoteDataSourceImpl(apiManager: apiManager);
    localDataSource = SourceLocalDataSourceImpl();
    repositoryContract = SourceRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
  }

  void getSource(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await repositoryContract.getSources(categoryId);
      if (response?.status == 'error') {
        emit(SourceErrorState(errorMessage: response!.message!));
        return;
      }
      if (response?.status == 'ok') {
        emit(SourceSuccessState(sourceList: response!.sources!));
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }
}
