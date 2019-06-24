import 'package:flutter/material.dart';
import 'package:yuka_clone/ui/resources/colors.dart';
import 'package:yuka_clone/ui/resources/style.dart';
import 'package:yuka_clone/ui/screens/list/list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuka clone',
      theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              brightness: Brightness.light, textTheme: AppStyle.lightTextTheme),
          accentColor: AppColors.primary,
          primaryColor: AppColors.accent,
          scaffoldBackgroundColor: AppColors.white_light,
          textTheme: AppStyle.textTheme,
          cardTheme: CardTheme(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)))),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: AppColors.white_icon),
          splashColor: AppColors.splash.withOpacity(0.5)),
      home: ProductsListScreen(),
    );
  }
}
