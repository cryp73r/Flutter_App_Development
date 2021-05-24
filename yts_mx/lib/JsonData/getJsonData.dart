import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getJsonData(String apiUrl) async {
  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode("${response.body}");
}