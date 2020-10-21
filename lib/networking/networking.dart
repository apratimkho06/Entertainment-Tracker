import 'dart:convert';
import 'dart:async';
import 'package:entertainmenttracker/model/movie_results.dart';
import 'package:entertainmenttracker/model/multi_search.dart';
import 'package:entertainmenttracker/model/multi_search_results.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/model/series_results.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static final String baseUrl = 'https://api.themoviedb.org/3';
  static final String apiKey = '81f340338a84311b318b04a016742e74';
  static final String multiSearchUrl =
      'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&language=en-US&page=1&include_adult=false';

  static Future<List<Movie>> fetchMovies(
      http.Client client, String filter) async {
    final response = await client.get('$baseUrl/movie/$filter?api_key=$apiKey');
    print(response.statusCode);
    return compute(parseMovies, response.body);
  }

  static List<Movie> parseMovies(responseBody) {
    final Map parsed = json.decode(responseBody);
    final movieResults = MovieResults.fromJson(parsed);
    return movieResults.results;
  }

  static Future<List<Series>> fetchSeries(
      http.Client client, String filter) async {
    final response = await client.get('$baseUrl/tv/$filter?api_key=$apiKey');
    print(response.statusCode);
    return compute(parseSeries, response.body);
  }

  static List<Series> parseSeries(responseBody) {
    final Map parsed = json.decode(responseBody);
    final seriesResults = SeriesResults.fromJson(parsed);
    return seriesResults.results;
  }

  static Future<List<MultiSearch>> fetchQuery(
      http.Client client, String query) async {
    final response = await client.get('$multiSearchUrl&query=$query');
    print(response.statusCode);
    return compute(parseMultiSearch, response.body);
  }

  static List<MultiSearch> parseMultiSearch(responseBody) {
    final Map parsed = json.decode(responseBody);
    final multiSearchResults = MultiSearchResults.fromJson(parsed);
    return multiSearchResults.results;
  }
}
