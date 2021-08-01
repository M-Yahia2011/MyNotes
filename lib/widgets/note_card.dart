import 'package:flutter/material.dart';
import 'package:my_notes/models/note.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_notes/providers/note_provider.dart';
import 'package:provider/provider.dart';
import '../views/note_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 5),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.orange[100],
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NoteScreen.routeName, arguments: note);
        },
        child: Container(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        note.title!,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    FavoriteButton(note: note)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  note.note!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: SizedBox()),
                      Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            intl.DateFormat.yMMMMd()
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
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await Provider.of<NoteProvider>(context, listen: false)
              .toggleFavorite(widget.note.id);
          setState(() {});
        },
        icon: widget.note.favorite == 1
            ? Icon(
                Icons.favorite,
                color: Colors.pink[300],
                size: 32,
              )
            : Icon(
                Icons.favorite_border_outlined,
                color: Colors.pink[300],
                size: 32,
              ));
  }
}
