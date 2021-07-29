import 'package:flutter/material.dart';
import '../models/note.dart';
import '../helpers/database_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  var database = DBHelper.db;
  List<Note> get notes {
    return [..._notes];
  }

  Future<void> fetchDBNotes() async {
    try {
      List<Note> list = await database.getAllNotes();
      _notes = list;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addNote(Map<String, dynamic> noteMap) async {
    try {
      Note newNote = Note.fromMap(noteMap);

      final noteID = await database.insert(noteMap);
      newNote.id = noteID;
      _notes.add(newNote);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await database.deleteNote(id);
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  /// update some note
  Future<void> updateNote(Map<String, dynamic> noteMap) async {
    try {
      await database.updateNote(noteMap);

      Note newNote = Note.fromMap(noteMap);
      int oldIdx = _notes.indexWhere((oldNote) => oldNote.id == noteMap['id']);
      _notes[oldIdx] = newNote;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> clearNotes() async {
    await database.clearDatabae();
    _notes.clear();
    notifyListeners();
  }
}
