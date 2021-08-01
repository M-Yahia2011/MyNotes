import 'package:flutter/material.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:my_notes/widgets/note_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Favorites"),
          centerTitle: true,
        ),
        body: Consumer<NoteProvider>(builder: (ctx, provider, _) {
          return ListView.builder(
            itemCount: provider.favoriteNotes.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, idx) {
              return NoteCard(provider.favoriteNotes[idx]);
            },
          );
        }));
  }
}
