import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notes_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_string.dart';
class NotesListPage extends StatelessWidget {
  NotesListPage({super.key});
  final NotesController controller = Get.find<NotesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.notes.isEmpty) {
        return const Center(child: Text(AppStrings.noNotesFound));
      }

      return ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (_, index) {
          final note = controller.notes[index];

          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.toNamed(AppRoutes.edit, arguments: note);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.deleteNote(note.id);
                  },
                ),
              ],
            ),

          );
        },
      );
    });
  }
}
