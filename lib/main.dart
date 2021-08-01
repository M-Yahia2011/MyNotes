import 'package:flutter/material.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:my_notes/views/favorite_screen.dart';
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
      create: (ctx) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MyNotes",
        theme: ThemeData(
            primarySwatch: Colors.amber,
            appBarTheme: AppBarTheme(color: Colors.white, elevation: 4),
            textTheme: TextTheme(bodyText2: TextStyle(fontSize: 18))),
        home: Home(),
        routes: {
          AddNoteScreen.routeName: (ctx) => AddNoteScreen(),
          NoteScreen.routeName: (ctx) => NoteScreen(),
          FavoriteScreen.routeName: (ctx)=> FavoriteScreen(),
        },
      ),
    );
  }
}
