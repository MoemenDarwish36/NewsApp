import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';

@injectable
class NewsDetailsViewModel extends Cubit<NewsState> {
  NewsRepositoryContract repositoryContract;

  NewsDetailsViewModel({required this.repositoryContract})
      : super(NewsLoadingState());

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
