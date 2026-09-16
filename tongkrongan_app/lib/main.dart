import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/themes/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const TongkronganApp());
}

class TongkronganApp extends StatelessWidget {
  const TongkronganApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Tongkrongan - Hangout Discovery App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}