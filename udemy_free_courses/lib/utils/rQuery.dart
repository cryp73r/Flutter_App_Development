import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getQuery() async {
  var apiUrl = Uri.https("www.udemy.com", "/api-2.0/courses/");
  http.Response response = await http.get(apiUrl, headers: {"Authorization": "Basic SGQwQXNOTTg2NmtrUFNFOUhYcTk2VHM5SjhTbnNWRllwM2FEcW5ZTTppWmtKd042WEp6VzN5bXRRSHJoMk1IZVhValJnTElrMDRUQ2Q5UHhwanRtTlJ5SnlNdDdmSUJyOVh6emdBenBVaXlrcFZmdGJrOUpZTjZNemhUcHFWTFB5RnBHSzdjcXFGbEV5dkF0c05ra2pEYWVFUVc1UzhlQ3gwODVkaFRhdg=="});
  return json.decode(response.body);

}