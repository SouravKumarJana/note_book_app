import 'package:get/get.dart';
import 'package:note_book_app/routes/app_routes.dart';
import '../ui/pages/home_page.dart';
import '../bindings/app_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => NotesHomePage(),
      binding: AppBinding(),
    ),
  ];
}
