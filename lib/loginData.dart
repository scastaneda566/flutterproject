import 'dart:convert';
import 'package:http/http.dart' as http;

class loginData {
  static Future<String> getJson(String url, String outgoing) async
  {
    String ret = "";

    final uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);

      ret = response.body;
    }
    catch(e)
    {
      print(e.toString());
    }

    return ret;
  }
}