import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // استخدم قيمة افتراضية
  Locale _locale = Locale('en', 'US'); // استخدم قيمة افتراضية

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  SettingsProvider() {
    _initializeSettings(); // تأكد من تهيئة المتغيرات بشكل صحيح
  }

  void changeLang(BuildContext context, String lang) {
    _locale = Locale(lang);
    context.setLocale(_locale); // تأكد من أن _locale ليس null
    notifyListeners();
    _saveLocale();
  }

  void changeTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<void> _initializeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // تحميل themeMode المحفوظة
    String? savedTheme = prefs.getString('themeMode');
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    // تحميل locale المحفوظة
    String? savedLocale = prefs.getString('locale');
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }

    notifyListeners();
  }

  Future<void> _saveLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', _locale.languageCode);
  }
}
