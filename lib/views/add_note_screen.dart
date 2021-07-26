import 'package:flutter/material.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = '/add_note_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                  color: Colors.grey,
                  height: AppBar().preferredSize.height,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.mark_as_unread)),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: "Tiltle"),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
