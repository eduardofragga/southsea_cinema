import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model', () {
    test('stores the supplied movie properties', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        ageRating: '12A',
        synopsis: 'A test synopsis.',
        screeningTime: '18:30',
        runtime: '1h 30min',
        ticketPrice: 7.50,
        posterPath: 'assets/images/test.jpg',
      );

      expect(movie.id, 'test-movie');
      expect(movie.title, 'Test Movie');
      expect(movie.ageRating, '12A');
      expect(movie.synopsis, 'A test synopsis.');
      expect(movie.screeningTime, '18:30');
      expect(movie.runtime, '1h 30min');
      expect(movie.ticketPrice, 7.50);
      expect(movie.posterPath, 'assets/images/test.jpg');
    });

    test('formats a price with pence to two decimal places', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        ageRating: '12A',
        synopsis: 'A test synopsis.',
        screeningTime: '18:30',
        runtime: '1h 30min',
        ticketPrice: 7.50,
        posterPath: 'assets/images/test.jpg',
      );

      expect(movie.formattedPrice, '£7.50');
    });

    test('formats a whole-pound price with two decimal places', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        ageRating: '12A',
        synopsis: 'A test synopsis.',
        screeningTime: '18:30',
        runtime: '1h 30min',
        ticketPrice: 8.0,
        posterPath: 'assets/images/test.jpg',
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('creates a Movie from JSON', () {
      final json = {
        'id': 'test-movie',
        'title': 'Test Movie',
        'ageRating': '12A',
        'synopsis': 'A test synopsis.',
        'screeningTime': '18:30',
        'runtime': '1h 30min',
        'ticketPrice': 7.50,
        'posterPath': 'assets/images/test.jpg',
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 'test-movie');
      expect(movie.title, 'Test Movie');
      expect(movie.ageRating, '12A');
      expect(movie.synopsis, 'A test synopsis.');
      expect(movie.screeningTime, '18:30');
      expect(movie.runtime, '1h 30min');
      expect(movie.ticketPrice, 7.50);
      expect(movie.posterPath, 'assets/images/test.jpg');
    });

    test('converts a Movie to JSON', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        ageRating: '12A',
        synopsis: 'A test synopsis.',
        screeningTime: '18:30',
        runtime: '1h 30min',
        ticketPrice: 7.50,
        posterPath: 'assets/images/test.jpg',
      );

      final json = movie.toJson();

      expect(json['id'], 'test-movie');
      expect(json['title'], 'Test Movie');
      expect(json['ageRating'], '12A');
      expect(json['synopsis'], 'A test synopsis.');
      expect(json['screeningTime'], '18:30');
      expect(json['runtime'], '1h 30min');
      expect(json['ticketPrice'], 7.50);
      expect(json['posterPath'], 'assets/images/test.jpg');
    });

    test('reads a whole-number ticket price from JSON', () {
      final json = {
        'id': 'test-movie',
        'title': 'Test Movie',
        'ageRating': '12A',
        'synopsis': 'A test synopsis.',
        'screeningTime': '18:30',
        'runtime': '1h 30min',
        'ticketPrice': 8,
        'posterPath': 'assets/images/test.jpg',
      };

      final movie = Movie.fromJson(json);

      expect(movie.ticketPrice, 8.0);
      expect(movie.formattedPrice, '£8.00');
    });
  });
}
