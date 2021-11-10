import 'package:my_notes/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  DBHelper._(); // a named private constructor
  static final DBHelper db = DBHelper._();

  static Database? _database;

  Future<Database> get getDatabase async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(path.join(dbPath, 'notes.db'),
        version: 1, onOpen: (_) {}, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, favorite INTEGER)');
    });
  }

  Future<int> insert(Map<String, dynamic> noteMap) async {
    try {
      final db = await getDatabase;
      final noteID = await db.insert("Notes", noteMap,
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(noteID);
      return noteID;
    } catch (error) {
      throw error;
    }
  }

  Future<Note?> getNote(int id) async {
    final db = await getDatabase;
    var queryResult = await db.query("Notes", where: "id = ?", whereArgs: [id]);
    return queryResult.isNotEmpty ? Note.fromMap(queryResult.first) : null;
  }

  Future<List<Note>> getAllNotes() async {
    try {
      final db = await getDatabase;
      var res = await db.query("Notes");

      List<Note> list = [];
      if (res.isNotEmpty) {
        list = res.map((note) => Note.fromMap(note)).toList();
      }
      return list;
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteNote(String id) async {
    final db = await getDatabase;
    await db.delete("Notes", where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateNote(Map<String, dynamic> noteMap) async {
    final db = await getDatabase;
    int x = await db
        .update('Notes', noteMap, where: "id = ?", whereArgs: [noteMap['id']]);
  }

  Future<void> clearDatabase() async {
    final db = await getDatabase;
    // delete all rows but keep continue with the IDs flow as it is
    db.execute("DELETE FROM Notes");
  }
}
