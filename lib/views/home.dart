import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:my_notes/helpers/search_notes.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:my_notes/views/add_note_screen.dart';
import 'package:my_notes/widgets/note_card.dart';
import 'package:provider/provider.dart';

import 'favorite_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum selection { delete, share }

class _HomeState extends State<Home> {
  late Future _future;

  Future<void> fetch() async {
    try {
      await Provider.of<NoteProvider>(context, listen: false).fetchDBNotes();
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    _future = fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NoteProvider>(context);
    print('built');
    double screenWidth = MediaQuery.of(context).size.width;

    final body = SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: FutureBuilder(
            future: _future,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (Provider.of<NoteProvider>(context, listen: false)
                  .notes
                  .isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          "assets/cat.png",
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Let's add some notes!",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                );
              }
              return Consumer<NoteProvider>(builder: (ctx, provider, _) {
                return screenWidth > 400
                    ? ListView.builder(
                        itemCount: provider.notes.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, idx) {
                          return NoteCard(provider.notes[idx]);
                        },
                      )
                    : GridView.builder(
                        itemCount: provider.notes.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          // childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (ctx, idx) {
                          return NoteCard(provider.notes[idx]);
                        },
                      );
              });
            }),
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Platform.isIOS
          ? CupertinoApp(
              builder: (ctx, _) {
                return body;
              },
              debugShowCheckedModeBanner: false,
              title: 'MyNotes',
            )
          : Scaffold(
              appBar: AppBar(
                elevation: 4,
                title: FittedBox(
                  child: Text(
                    "My Notes",
                  ),
                ),
                centerTitle: true,
                actions: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          child: Text("Delete All"),
                          value: selection.delete,
                        )
                      ];
                    },
                    onSelected: (value) {
                      switch (value) {
                        case selection.delete:
                          Provider.of<NoteProvider>(context, listen: false)
                              .clearNotes();
                          break;
                      }
                    },
                  )
                ],
              ),
              body: body,
              bottomNavigationBar: BottomAppBar(
                // color: Colors.amber,
                shape: CircularNotchedRectangle(),
                notchMargin: 4,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BottomBarActions(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddNoteScreen.routeName);
                },
                child: Icon(Icons.add),
                elevation: 0,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
    );
  }
}

class BottomBarActions extends StatelessWidget {
  const BottomBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.list))),
        Expanded(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  semanticLabel: 'favorite',
                ))),
        SizedBox(width: 50),
        Expanded(
            child: IconButton(
                onPressed: () async {
                  await showSearch(
                      context: context,
                      delegate: SearchNotes(
                          Provider.of<NoteProvider>(context, listen: false)
                              .notes));
                },
                icon: Icon(Icons.search))),
        Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.list))),
      ],
    );
  }
}
