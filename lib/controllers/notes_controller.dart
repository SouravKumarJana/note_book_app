import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/base_controller.dart';
import '../../data/repositories/notes_repository.dart';
import '../../entities/note_entity.dart';


class NotesController extends BaseController {
  final NotesRepository repo = Get.find();

  final notes = <NoteEntity>[].obs;

  final noteTitleController = TextEditingController();
  final noteContentController = TextEditingController();

  final isSaving = false.obs;

  String? editingNoteId;

  @override
  void onInit() {
    super.onInit();

    repo.watchNotes().listen((data) {
      notes.value = data;
    });
  }

  
  Future<void> addNote() async {
    final title = noteTitleController.text.trim();
    final content = noteContentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    isSaving.value = true;

    await noteExecutor(
      repo.createNote(title, content),
    );

    noteTitleController.clear();
    noteContentController.clear();

    isSaving.value = false;
  }

  void initEditFromArguments() {
    final note = Get.arguments as NoteEntity?;

    if (note == null) return;

    editingNoteId = note.id;
    noteTitleController.text = note.title;
    noteContentController.text = note.content;
}

  Future<void> updateNote() async {
    final title = noteTitleController.text.trim();
    final content = noteContentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Error", "All fields required");
      return;
    }

    if (editingNoteId == null) return;

    isSaving.value = true;

    await noteExecutor(
      repo.updateNote(editingNoteId!, title, content),
    );

    isSaving.value = false;

    noteTitleController.clear();
    noteContentController.clear();
    editingNoteId = null;

    Get.back(); // return to list tab
  }


  Future<void> deleteNote(String id) async {
    await noteExecutor(
      repo.deleteNote(id),
    );
  }

  @override
  void onClose() {
    noteTitleController.dispose();
    noteContentController.dispose();
    super.onClose();
  }
}
