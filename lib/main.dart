import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'config/bindings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Al Hadith',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}