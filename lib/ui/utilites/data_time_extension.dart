import 'package:intl/intl.dart';

extension TimeExtension on DateTime {
  String get toFormattedDate {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }
}
