import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/category/cubit/source_state.dart';

import '../../repository/sources/source_repository_contract.dart';

@injectable
class CategoryDetailsViewModel extends Cubit<SourceState> {
  SourceRepositoryContract repositoryContract;

  CategoryDetailsViewModel({required this.repositoryContract})
      : super(SourceLoadingState());

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
