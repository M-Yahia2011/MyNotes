import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = '/add_note_screen';

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleTextController = TextEditingController();
  final _noteTextController = TextEditingController();
  late FocusNode myFocusNode;
  Future<void> insert() async {
    Map<String, dynamic> noteMap = {
      "title": _titleTextController.text,
      "note": _noteTextController.text,
      "date": DateTime.now().toIso8601String()
    };

    await Provider.of<NoteProvider>(context, listen: false).addNote(noteMap);
  }

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              if (_titleTextController.text.isEmpty) {
                return;
              }
              await insert();
              Navigator.of(context).pop();
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
                  autofocus: true,
                  style: TextStyle(fontSize: 22, height: 1),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Divider(
                color: Colors.grey,
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
