import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book_app/controllers/home_controller.dart';
import 'notes_list_page.dart';
import 'add_note_page.dart';
import '../../constants/app_string.dart';

class NotesHomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  NotesHomePage({super.key}); 

  @override
  Widget build(BuildContext context) {
    final pages = [
      NotesListPage(),
      AddNotePage(),
    ];

    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appTitle)),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: AppStrings.notesTab,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "AppStrings.addNoteTab",
            ),
          ],
        ),
      );
    });
  }
}
