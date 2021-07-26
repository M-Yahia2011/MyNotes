import 'package:flutter/material.dart';
import 'package:my_notes/views/add_note_screen.dart';
import 'package:my_notes/views/note_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.amber[100],
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, NoteScreen.routeName);
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
                              "Title",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "part of the text",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [FittedBox(child: Text('Date'))],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: 20,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.note))),
              Expanded(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.calendar_today))),
              SizedBox(width: 50),
              Expanded(
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))),
              Expanded(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.list))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNoteScreen.routeName);
        },
        child: Icon(Icons.add),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
