import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notes_controller.dart';

class NotesListPage extends StatelessWidget {
  NotesListPage({super.key});
  final NotesController controller = Get.find<NotesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.notes.isEmpty) {
        return const Center(child: Text("No Notes Found"));
      }

      return ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (_, index) {
          final note = controller.notes[index];

          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => controller.deleteNote(note.id),
            ),
          );
        },
      );
    });
  }
}
