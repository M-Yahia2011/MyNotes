import 'package:flutter/material.dart';
import 'package:my_notes/models/note.dart';
import 'package:intl/intl.dart' as intl;
import '../views/note_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) =>
          {}, //Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id!),
      key: ValueKey(note.id),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.orange[100],
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, NoteScreen.routeName, arguments: note);
          },
          child: Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      note.title!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      note.note!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: SizedBox()),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              intl.DateFormat.yMMM()
                                  .format(DateTime.parse(note.date!)),
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
