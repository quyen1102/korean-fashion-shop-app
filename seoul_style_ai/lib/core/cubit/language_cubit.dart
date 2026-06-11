import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SharedPreferences sharedPreferences;
  static const String _key = 'app_language';

  LanguageCubit(this.sharedPreferences)
      : super(LanguageState(
            Locale(sharedPreferences.getString(_key) ?? 'en')));

  Future<void> setLanguage(String languageCode) async {
    await sharedPreferences.setString(_key, languageCode);
    emit(LanguageState(Locale(languageCode)));
  }
}
