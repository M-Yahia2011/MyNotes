import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/models/note.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = '/note_screen';

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

enum selection { delete, share }

class _AddNoteScreenState extends State<NoteScreen> {
  final _titleTextController = TextEditingController();
  final _noteTextController = TextEditingController();
  String? oldTitle;
  String? oldNote;
  int? _favourite;
  Future<void> update(String id) async {
    Map<String, dynamic> noteMap = {
      "id": id,
      "title": _titleTextController.text,
      "note": _noteTextController.text,
      "favorite": _favourite,
      "date": DateTime.now().toIso8601String()
    };

    await Provider.of<NoteProvider>(context, listen: false).updateNote(noteMap);
  }

  bool checkInput() {
    if (_titleTextController.text.isEmpty && _noteTextController.text.isEmpty) {
      return false;
    }
    if (_titleTextController.text.isEmpty &&
        _noteTextController.text.isNotEmpty) {
      _titleTextController.text = "No Title";
    }
    if (_titleTextController.text == oldTitle &&
        _noteTextController.text == oldNote) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Note note = ModalRoute.of(context)!.settings.arguments as Note;
    _titleTextController.text = note.title!;
    _noteTextController.text = note.note!;
    _favourite = note.favorite;
    oldTitle = note.title!;
    oldNote = note.note!;
    return Scaffold(
      appBar: AppBar(
        title: Text("MyNotes"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case selection.delete:
                  Navigator.of(context).pop();
                  await Provider.of<NoteProvider>(context, listen: false)
                      .deleteNote(note.id!);
                  break;
                case 'share':
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Delete"),
                  value: selection.delete,
                ),
                PopupMenuItem(
                  child: Text("Share"),
                  value: selection.share,
                ),
              ];
            },
          )
        ],
        leading: IconButton(
            onPressed: () async {
              if (checkInput() == true) {
                await update(note.id!);
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.done)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _titleTextController,
                  style: TextStyle(fontSize: 22, height: 1),
                  keyboardType: TextInputType.text,
                  onEditingComplete: () => TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              Divider(
                color: Colors.amber,
                height: 0,
                thickness: 0,
              ),
              Expanded(
                child: TextField(
                  controller: _noteTextController,
                  style: TextStyle(fontSize: 22, height: 1),
                  cursorColor: Colors.black,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    fillColor: Colors.amber[100],
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                  maxLines: null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
