import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'noteView.dart';
import 'NavBar.dart';
import 'Note.dart';
import 'loginScreen.dart';

class noteData {
  Future<Note> getNote(String url, String outgoing) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //server returns ok response, parse json
      return Note.fromJson(jsonDecode(response.body));
    } else {
      //throw an exception, server did not return ok response.
      throw Exception('Failed to load');
    }
  }

  Future<Note> deleteNote(String url, String id) async {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      //server returns ok response, parse json
      return Note.fromJson(jsonDecode(response.body));
    } else {
      //throw an exception, server did not return ok response.
      throw Exception('Failed to load');
    }
  }

  static Future<String> getNotes(String id) async {
    String jwt = GlobalData.token;

    String url =
        "https://marky-mark.herokuapp.com/api/users/$id/notes?searchText="
        "&tags[]=&jwtToken=$jwt";
    final uri = Uri.parse(url);
    String ret = "";

    try {
      http.Response response = await http.get(uri);

      ret = response.body;
    } catch (e) {
      print(e.toString());
    }

    return ret;
  }
}
