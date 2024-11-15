import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/ui/screen/home_screen/home_screen.dart';
import 'package:news_app/ui/screen/news_details/news_details.dart';
import 'package:news_app/ui/screen/splash_screen/splash_screen.dart';
import 'package:news_app/ui/utilites/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LanguageProvider languageProvider = LanguageProvider();

  await languageProvider.getLanguage();
  runApp(ChangeNotifierProvider(
      create: (_) => languageProvider, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(languageProvider.selectedLanguage),
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (_) => const Splash(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        NewsDetails.routeName: (_) => NewsDetails(),
      },
      initialRoute: Splash.routeName,
      theme: AppTheme.lightTheme,


    );
  }
}

