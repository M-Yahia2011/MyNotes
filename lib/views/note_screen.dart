import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);
  static const routeName = '/note_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.done),
          ),
          title: Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration(labelText: "Title"),
            ),
          )),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Text('some text'),
        ),
      ),
    );
  }
}
