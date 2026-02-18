import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book_app/controllers/notes_controller.dart';

class AddNotePage extends StatelessWidget {
  
  final NotesController controller = Get.find<NotesController>();
  
  AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: controller.noteTitleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: controller.noteContentController,
            decoration: const InputDecoration(labelText: "Content"),
          ),
          const SizedBox(height: 20),
          Obx(() => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : controller.addNote,
                child: controller.isSaving.value
                    ? const CircularProgressIndicator()
                    : const Text("Save"),
              )),
        ],
      ),
    );
  }
}
