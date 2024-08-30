import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/core/theme/app_theme.dart';
import 'package:todo_4pm/modules/auth/pages/create_account_screen.dart';
import 'package:todo_4pm/modules/auth/pages/login_screen.dart';
import 'package:todo_4pm/modules/auth/pages/sign_up_screen.dart';
import 'package:todo_4pm/modules/layout/layout.dart';
import 'package:todo_4pm/modules/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';  // إضافة EasyLocalization

import 'firebase_options.dart';
import 'modules/layout/manager/main_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();  // تأكد من تهيئة EasyLocalization

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],  // اللغات المدعومة
      path: 'assets/translations',  // مسار ملفات الترجمة
      fallbackLocale: Locale('en', 'US'),  // اللغة الافتراضية في حال عدم العثور على الترجمة
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: Consumer<MainProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            locale: context.locale,  // ضبط اللغة
            supportedLocales: context.supportedLocales,  // اللغات المدعومة
            localizationsDelegates: context.localizationDelegates,  // إعدادات الترجمة
            themeMode: provider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routes: {
              SplashScreen.routeName: (_) => SplashScreen(),
              LayoutScreen.routeName: (_) => LayoutScreen(),
              CreateAccountScreen.routeName: (_) => CreateAccountScreen(),
              LoginScreen.routeName: (_) => LoginScreen(),
              SignUpScreen.routeName: (_) => SignUpScreen(),
            },
            initialRoute: SplashScreen.routeName,
          );
        },
      ),
    );
  }
}