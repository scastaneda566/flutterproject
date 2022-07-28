import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginScreen.dart';
import 'accountSettings.dart';
import 'search.dart';
import 'deleteNoteData.dart';
import 'markdownViewer.dart';

class noteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class Note {
  String name = "";
  String id = "";
  String body = "";
  Note(this.name, this.id, this.body);

  Note.fromJson(Map<String, dynamic> json) {
    name = json['noteName'];
    id = json['noteId'];
    body = json["noteBody"];
  }
}

class _NoteViewState extends State<noteView> {
  List<Note> _notes = <Note>[];

  Future<List<Note>> fetchNotes() async {
    String id = GlobalData.userId;
    String jwt = GlobalData.token;
    var url =
        "https://marky-mark-clone.herokuapp.com/api/users/$id/notes?searchText=&tags[]=&accessToken=$jwt";
    var response = await http.get(Uri.parse(url));
    print(response);
    var notes = <Note>[];

    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);
      for (var noteJson in notesJson["results"]) {
        notes.add(Note.fromJson(noteJson));
      }
    }

    GlobalData.notes = notes;
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
                  String id = GlobalData.userId;
                  String nid = GlobalData.notes[index].id;
                  String jwt = GlobalData.token;
                  String payload = '{"noteIds":["' + nid.trim() + '"]} ';
                  print(payload);

                  try {
                    String url =
                        'https://marky-mark-clone.herokuapp.com/api/users/$id/notes?&accessToken=$jwt';
                    ret = await deleteNoteData.getDelNoteJson(url, payload);
                    jsonObject = json.decode(ret);
                  } catch (e) {
                    print(e.toString());
                    return;
                  }

                  fetchNotes().then((value) {
                    setState(() {
                      _notes = <Note>[];
                      _notes.addAll(value);
                    });
                  });

                  Navigator.of(context).pop();
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

  String tempFirst = GlobalData.firstName;
  String tempLast = GlobalData.lastName;

  @override
  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  GlobalData.userId = '';
                  GlobalData.firstName = '';
                  GlobalData.lastName = '';
                  GlobalData.email = '';
                  GlobalData.password = '';
                  tempFirst = '';
                  tempLast = '';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginScreen()));
                  print(GlobalData.firstName);
                },
                child: Text("Logout"),
              ),
            ],
          );
        });
  }

  Icon customIcon = const Icon(Icons.search);

  Widget build(BuildContext context) {
    tempFirst = GlobalData.firstName;
    tempLast = GlobalData.lastName;
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Color(0xFF6CA8F1), opacity: 1, size: 40),
        title: Text('$tempLast, $tempFirst',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF212121),
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            fetchNotes().then((value) {
              setState(() {
                _notes = <Note>[];
                _notes.addAll(value);
              });
            });
          },
        ),
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => accountSettings()));
            },
          ),
        ],
      ),
      body: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF424242),
                    Color(0xFF424242),
                    Color(0xFF424242),
                    Color(0xFF424242),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      _notes[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => markdownViewer(
                                text: _notes[index].body,
                                title: _notes[index].name)),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        deleteNote(_notes[index].id, index);
                      },
                    ),
                  );
                },
                itemCount: _notes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
