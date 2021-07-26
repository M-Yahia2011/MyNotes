import 'package:flutter/material.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:my_notes/views/note_screen.dart';
import 'package:provider/provider.dart';

import 'views/add_note_screen.dart';
import 'views/home.dart';

void main() {
  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        NoteProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: {
          AddNoteScreen.routeName: (context) => AddNoteScreen(),
          NoteScreen.routeName: (ctx) => NoteScreen(),
        },
      ),
    );
  }
}
