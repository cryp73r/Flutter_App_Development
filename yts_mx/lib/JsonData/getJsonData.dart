import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map> getJsonData(String apiUrl,
    {int? limit,
    int? page,
    String? quality,
    int? minimumRating,
    String? queryTerm,
    String? genre,
    String? sortBy,
    String? orderBy,
    bool? withRtRatings,
    int? movieId,
    bool? withImages,
    bool? withCast}) async {
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
  if (minimumRating != null) {
    apiUrl += "minimum_rating=$minimumRating&";
  }
  if (queryTerm != null) {
    apiUrl += "query_term=$queryTerm&";
  }
  if (genre != null) {
    if (genre != "All") {
      apiUrl += "genre=$genre&";
    }
  }
  if (sortBy != null) {
    apiUrl += "sort_by=$sortBy&";
  }
  if (orderBy != null) {
    apiUrl += "order_by=$orderBy&";
  }
  if (withRtRatings != null) {
    apiUrl += "with_rt_ratings=$withRtRatings&";
  }
  if (movieId != null) {
    apiUrl += "movie_id=$movieId&";
  }
  if (withImages != null) {
    apiUrl += "with_images=$withImages&";
  }
  if (withCast != null) {
    apiUrl += "with_cast=$withCast&";
  }
  apiUrl = apiUrl.substring(0, apiUrl.length-1);
  response = await http.get(Uri.parse(apiUrl));
  return json.decode("${response.body}");
}
