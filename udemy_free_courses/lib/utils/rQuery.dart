import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getQuery() async {
  var apiUrl = Uri.https("www.udemy.com", "/api-2.0/courses/");
  http.Response response = await http.get(apiUrl, headers: {"Authorization": "<Secret Code>"});
  return json.decode(response.body);

}