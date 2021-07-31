import 'package:flutter/material.dart';
import 'package:my_notes/widgets/note_card.dart';

import '../models/note.dart';

class SearchNotes extends SearchDelegate {
  final List<Note> notes;
  SearchNotes(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Note> result = notes
        .where((note) =>
            note.note!.toLowerCase().contains(query.toLowerCase()) ||
            note.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (ctx, idx) => NoteCard(result[idx]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Note> result = notes
        .where((note) =>
            note.note!.toLowerCase().contains(query.toLowerCase()) ||
            note.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (ctx, idx) => NoteCard(result[idx]));
  }
}
