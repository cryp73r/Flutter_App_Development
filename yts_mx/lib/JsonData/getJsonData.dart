import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getJsonData(String apiUrl, {int limit, int page, String quality, int minimum_rating, String query_term, String genre, String sort_by, String order_by, bool with_rt_ratings, int movie_id, bool with_images, bool with_cast}) async {
  http.Response response;
  if (limit != null) {
    response = await http.get(Uri.parse(apiUrl + "limit=$limit&"));
  }
  else if (page != null) {
    response = await http.get(Uri.parse(apiUrl + "page=$page&"));
  }
  else if (quality != null) {
    response = await http.get(Uri.parse(apiUrl + "quality=$quality&"));
  }
  else if (minimum_rating != null) {
    response = await http.get(Uri.parse(apiUrl + "minimum_rating=$minimum_rating&"));
  }
  else if (query_term != null) {
    response = await http.get(Uri.parse(apiUrl + "query_term=$query_term&"));
  }
  else if (genre != null) {
    response = await http.get(Uri.parse(apiUrl + "genre=$genre&"));
  }
  else if (sort_by != null) {
    response = await http.get(Uri.parse(apiUrl + "sort_by=$sort_by&"));
  }
  else if (order_by != null) {
    response = await http.get(Uri.parse(apiUrl + "order_by=$order_by&"));
  }
  else if (with_rt_ratings != null) {
    response = await http.get(Uri.parse(apiUrl + "with_rt_ratings=$with_rt_ratings&"));
  }
  else if (movie_id != null) {
    response = await http.get(Uri.parse(apiUrl + "movie_id=$movie_id&"));
  }
  else if (with_images != null) {
    response = await http.get(Uri.parse(apiUrl + "with_images=$with_images&"));
  }
  else if (with_cast != null) {
    response = await http.get(Uri.parse(apiUrl + "with_cast=$with_cast&"));
  }
  else {
    response = await http.get(Uri.parse(apiUrl));
  }

  return json.decode("${response.body}");
}