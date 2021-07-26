import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  Future<void> addNote(Note note) async {
    /// store in RAM and in Database
    try {
      // add to DB
      // if ok
      _notes.add(note);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  deleteNote() {}
  updateNote() {}
}
