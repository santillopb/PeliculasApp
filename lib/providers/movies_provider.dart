
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = 'e3ff5afce9833b16997dbdd1d81c18b7';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('Movies provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }
  getOnDisplayMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
     'api_key': _apiKey,
     'language': _language,
     'page': '1'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    
    this.onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();

  }
  getPopularMovies() async {
      var url = Uri.https(_baseUrl, '3/movie/popular', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'
      });

      final response = await http.get(url);
      final popularResponse = PopularResponse.fromJson(response.body);

      popularMovies = [...popularMovies, ...popularResponse.results];
      notifyListeners();
    }
}

