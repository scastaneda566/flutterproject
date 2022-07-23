import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'noteData.dart';
import 'loginScreen.dart';
import 'noteView.dart';

class navBar extends StatefulWidget {
  @override
  navBarState createState() => navBarState();
}

class navBarState extends State<navBar> {
  List<Note> _notes = <Note>[];

  void initState() {
    String url =
        "https://marky-mark.herokuapp.com/api/users/%7BuserId%7D/notes";
    Future<List<Note>> ret = noteData.getNotes(url, GlobalData.userId);
    _notes = ret as List<Note>;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 17, 29, 45),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _notes[index].name,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _notes.length,
        ),
      ),
    );
  }
}
