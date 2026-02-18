import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/base_controller.dart';
import '../../data/repositories/notes_repository.dart';
import '../../entities/note_entity.dart';

class NotesController extends BaseController {
  final NotesRepository repo = Get.find();

  // Reactive Notes List
  final notes = <NoteEntity>[].obs;

  // Text Controllers (moved here)
  final noteTitleController = TextEditingController();
  final noteContentController = TextEditingController();

  // Optional: Form validation state
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to notes stream
    repo.watchNotes().listen((data) {
      notes.value = data;
    });
  }

  // Add Note
  Future<void> addNote() async {
    final noteTtitle = noteTitleController.text.trim();
    final noteContent = noteContentController.text.trim();

    if (noteTtitle.isEmpty || noteContent.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    isSaving.value = true;

    await callApi(
      repo.createNote(noteTtitle, noteContent),
    );

    noteTitleController.clear();
    noteContentController.clear();

    isSaving.value = false;
  }

  // Delete Note
  Future<void> deleteNote(String id) async {
    await callApi(
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
