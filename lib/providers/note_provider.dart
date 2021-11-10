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
      final String noteID = await database.insert(noteMap);
      noteMap["id"] = noteID;
      Note newNote = Note.fromMap(noteMap);
      _notes.add(newNote);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await database.deleteNote(id);
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

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
    await database.clearDatabase();

    _notes.clear();

    notifyListeners();
  }

  Future<void> toggleFavorite(noteID) async {
    Note note = _notes.firstWhere((note) => note.id == noteID);
    final oldPreference = note.favorite;
    try {
      note.favorite == 1 ? note.favorite = 0 : note.favorite = 1;

      await database.updateNote(note.toMap());
      notifyListeners();
    } catch (error) {
      note.favorite = oldPreference;
      notifyListeners();
      throw error;
    }
  }

  List<Note> get favoriteNotes {
    return notes.where((note) => note.favorite == 1).toList();
  }
}
