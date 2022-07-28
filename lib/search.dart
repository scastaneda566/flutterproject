import 'dart:core';

import 'noteView.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';
import 'markdownViewer.dart';

class CustomSearchDelegate extends SearchDelegate<Note?> {
  List<Note> _notes = <Note>[];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          color: Color(0xFF212121),
          iconTheme: IconThemeData(color: Color(0xFF6CA8F1))),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  //this overide is to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          //print(GlobalData.notes[0].name);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  //this override is to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  //override to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Note> matchQuery = [];

    for (var note in GlobalData.notes) {
      if (note.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(note);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result.name,
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Color(0xFF424242),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => markdownViewer(
                      text: matchQuery[index].body,
                      title: matchQuery[index].name)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Note> matchQuery = [];
    for (var note in GlobalData.notes) {
      if (note.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(note);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result.name,
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Color(0xFF424242),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => markdownViewer(
                      text: matchQuery[index].body,
                      title: matchQuery[index].name)),
            );
          },
        );
      },
    );
  }
}
