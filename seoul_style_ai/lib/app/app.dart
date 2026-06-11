import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seoul_style_ai/l10n/app_localizations.dart';
import '../core/cubit/language_cubit.dart';
import '../core/cubit/language_state.dart';
import 'theme/app_theme.dart';
import 'router.dart';

class SeoulStyleApp extends StatelessWidget {
  const SeoulStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'SeoulStyle AI',
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('vi', ''), // Vietnamese
            Locale('ko', ''), // Korean
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}
