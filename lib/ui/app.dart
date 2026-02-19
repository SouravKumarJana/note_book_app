import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book_app/bindings/app_binding.dart';
import '../../routes/app_routes.dart';
import '../../routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
    );
  }
}
