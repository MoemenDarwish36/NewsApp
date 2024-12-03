import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/category/cubit/source_state.dart';
import 'package:news_app/ui/utilites/api_manger.dart';

class CategoryDetailsViewModel extends Cubit<SourceState> {
  CategoryDetailsViewModel() : super(SourceLoadingState());

  void getSource(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await ApiManager.getSources(categoryId);
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
//
// void updateSelectedIndex(int index) {
//   if (sourceList.isNotEmpty) {
//     emit(SourceChangeState(selectedIndex: index));
//   }
// }
}