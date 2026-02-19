import 'package:flutter/material.dart';
import '../../controllers/notes_controller.dart';
import 'package:get/get.dart';
import '../../constants/app_string.dart';
class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final NotesController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.initEditFromArguments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.editNote)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.noteTitleController,
              decoration: const InputDecoration(labelText: AppStrings.noteTitleLabel),
            ),
            TextField(
              controller: controller.noteContentController,
              decoration: const InputDecoration(labelText: AppStrings.noteContentLabel),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.isSaving.value
                      ? null
                      : controller.updateNote,
                  child: controller.isSaving.value
                      ? const CircularProgressIndicator()
                      : const Text(AppStrings.update),
                )),
          ],
        ),
      ),
    );
  }
}
