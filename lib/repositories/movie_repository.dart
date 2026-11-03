import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  Future<List<Movie>> getMovies() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/movies.json',
    );

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
        .toList();
  }

  Future<Movie?> getMovieById(String id) async {
    final movies = await getMovies();

    for (final movie in movies) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }
}
