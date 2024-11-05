import 'package:flutter/material.dart';
import 'package:news_app/ui/utilites/localization_extension.dart';
import 'package:provider/provider.dart';

import '../../../../provider/language_provider.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late LanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.localization.language,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 18,
          ),
          buildLanguageMenu(),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  buildLanguageMenu() => DropdownButton(
      value: languageProvider.selectedLanguage,
      items: [
        DropdownMenuItem<String>(
            value: "ar",
            child: Text(
              context.localization.arabic,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        DropdownMenuItem<String>(
            value: "en",
            child: Text(context.localization.english,
                style: Theme.of(context).textTheme.titleMedium)),
      ],
      isExpanded: true,
      onChanged: (newLanguageCode) {
        languageProvider.newLanguage =
            newLanguageCode ?? languageProvider.selectedLanguage;

        setState(() {});
      });
}
