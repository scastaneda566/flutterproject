import 'package:http/http.dart' as http;
import 'dart:convert';

class deleteNoteData {
  static Future<String> getDelNoteJson(String url, String outgoing) async {
    String ret = "";

    final uri = Uri.parse(url);
    try {
      http.Response response = await http.delete(uri,
          body: utf8.encode(outgoing),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          encoding: Encoding.getByName("utf-8"));

      ret = response.body;
    } catch (e) {
      print(e.toString());
    }

    return ret;
  }
}
