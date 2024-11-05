import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String selectedLanguage = "en";

  late SharedPreferences storageLanguage;

  Future<void> getLanguage() async {
    storageLanguage = await SharedPreferences.getInstance();
    if (storageLanguage.getBool("isEnglish") ?? false) {
      selectedLanguage = "en";
    } else {
      selectedLanguage = "ar";
    }
  }

  set newLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
    bool isEnglish = language == selectedLanguage ? true : false;
    _saveLanguage(isEnglish);
  }

  void _saveLanguage(bool isEnglish) {
    storageLanguage.setBool("isEnglish", isEnglish);
  }
}
