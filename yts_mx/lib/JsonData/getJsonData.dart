import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map> getJsonData(String apiUrl, {int limit, int page, String quality, int minimum_rating, String query_term, String genre, String sort_by, String order_by, bool with_rt_ratings, int movie_id, bool with_images, bool with_cast}) async {
  http.Response response;
  if (limit != null) {
    apiUrl += "limit=$limit&";
  }
  if (page != null) {
    apiUrl += "page=$page&";
  }
  if (quality != null) {
    apiUrl += "quality=$quality&";
  }
  if (minimum_rating != null) {
    apiUrl += "minimum_rating=$minimum_rating&";
  }
  if (query_term != null) {
    apiUrl += "query_term=$query_term&";
  }
  if (genre != null) {
    if (genre != "All") {
      apiUrl += "genre=$genre&";
    }
  }
  if (sort_by != null) {
    apiUrl += "sort_by=$sort_by&";
  }
  if (order_by != null) {
    apiUrl += "order_by=$order_by&";
  }
  if (with_rt_ratings != null) {
    apiUrl += "with_rt_ratings=$with_rt_ratings&";
  }
  if (movie_id != null) {
    apiUrl += "movie_id=$movie_id&";
  }
  if (with_images != null) {
    apiUrl += "with_images=$with_images&";
  }
  if (with_cast != null) {
    apiUrl += "with_cast=$with_cast&";
  }
  debugPrint(apiUrl);
  response = await http.get(Uri.parse(apiUrl)).timeout(Duration(seconds: 10));
  return json.decode("${response.body}");
}