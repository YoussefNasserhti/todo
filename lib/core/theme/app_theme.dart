import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Color(0xffDFECDB),
    useMaterial3: false,
    scaffoldBackgroundColor: Color(0xffDFECDB),
    // يمكنك إضافة المزيد من الإعدادات هنا إذا لزم الأمر
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xff1E1E1E), // اللون الأساسي للثيم الداكن
    scaffoldBackgroundColor: Color(0xff121212), // لون الخلفية للثيم الداكن
    brightness: Brightness.dark, // تعيين السطوع إلى الداكن
    useMaterial3: false,
    // يمكنك إضافة المزيد من الإعدادات هنا إذا لزم الأمر
  );
}
