import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'noteData.dart';
import 'noteView.dart';
import 'loginScreen.dart';

class navBar extends StatefulWidget {
  @override
  navBarState createState() => navBarState();
}

class navBarState extends State<navBar> {
  List<Note> _notes = <Note>[];

  Future<List<Note>> fetchNotes() async {
    String id = GlobalData.userId;
    String jwt = GlobalData.token;
    var url =
        "https://marky-mark.herokuapp.com/api/users/$id/notes?searchText=&tags[]=&jwtToken=$jwt";
    var response = await http.get(Uri.parse(url));
    var notes = <Note>[];

    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);
      print(notesJson["results"]);
      for (var noteJson in notesJson["results"]) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  void deleteNote(String noteId, int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Delete Note"),
            content: const Text("Are you sure you want to delete this note?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  var jsonObject;
                  String ret = '';
                  String userId = GlobalData.userId;
                  String jwt = GlobalData.token;

                  try {
                    String url =
                        "https://marky-mark.herokuapp.com/api/users/$userId/notes/$noteId/jwtToken=$jwt";
                    ret = await noteData.getDelNoteJson(url);
                    jsonObject = json.decode(ret);
                  } catch (e) {
                    print(e.toString());
                    return;
                  }

                  _notes.remove(index);
                },
                child: Text('Delete'),
              ),
            ],
          );
        });
  }

  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 17, 29, 45),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(
                _notes[index].name,
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.delete, color: Colors.white),
              onTap: () {
                deleteNote(_notes[index].id, index);
              },
            );
          },
          itemCount: _notes.length,
        ),
      ),
    );
  }
}
