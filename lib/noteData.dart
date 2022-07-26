import 'dart:convert';
import 'package:http/http.dart' as http;

class noteData {
  static Future<String> getAllNotesJson(String url) async {
    String ret = '';
    final uri = Uri.parse(url);

    try {
      http.Response response = await http.get(uri);

      ret = response.body;
    } catch (e) {
      print(e.toString());
    }

    return ret;
  }

  static Future<String> getDelNoteJson(String url) async {
    String ret = '';
    final uri = Uri.parse(url);

    try {
      http.Response response = await http.delete(uri);
      ret = response.body;
    } catch (e) {
      print(e.toString());
    }

    return ret;
  }
}
