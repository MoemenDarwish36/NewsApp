import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/screen/home_screen/news/cubit/news_state.dart';

import '../../../../utilites/api_manger.dart';

class NewsDetailsViewModel extends Cubit<NewsState> {
  NewsDetailsViewModel() : super(NewsLoadingState());

  void getNewsBySourceId({String? sourceId, int? page, int? pageSize}) async {
    try {
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsBySourceId(
          sourceId: sourceId, page: page, pageSize: pageSize);
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
