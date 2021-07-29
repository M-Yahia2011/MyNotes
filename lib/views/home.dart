import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:my_notes/providers/note_provider.dart';
import 'package:my_notes/views/add_note_screen.dart';
import 'package:my_notes/widgets/note_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

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
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: FittedBox(
            child: Text(
              "My Notes",
            ),
          ),
          centerTitle: true,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                      child: Text('EMPTY'),
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
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
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
        ),
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
            // Provider.of<NoteProvider>(context, listen: false).clearNotes();
            // Provider.of<NoteProvider>(context, listen: false).addNote(
            //   new Note(
            //       id: Random(5).nextInt(20),
            //       title: 'Welcome',
            //       note: 'hello there!',
            //       date: DateTime.now().toIso8601String()),
            // );
          },
          child: Icon(Icons.add),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.note))),
        Expanded(
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_today_rounded,
                  semanticLabel: 'Calender',
                ))),
        SizedBox(width: 50),
        Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.search))),
        Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.list))),
      ],
    );
  }
}
