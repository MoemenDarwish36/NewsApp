import 'package:news_app/model/Sources.dart';

abstract class SourceState {}

/// parents

class SourceLoadingState extends SourceState {}

class SourceErrorState extends SourceState {
  String errorMessage;

  SourceErrorState({required this.errorMessage});
}

class SourceSuccessState extends SourceState {
  List<Source> sourceList;

  SourceSuccessState({required this.sourceList});
}
// class SourceChangeState extends SourceState {
//   int selectedIndex;
//   SourceChangeState({required this.selectedIndex});
// }
