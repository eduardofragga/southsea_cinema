
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieRepository', () {
    test('returns the expected movies', () async {
      final repository = MovieRepository();

      final movies = await repository.getMovies();

      expect(movies.length, 2);
      expect(movies[0].id, 'the-intern');
      expect(movies[0].title, 'The Intern');
      expect(movies[1].id, 'john-carter');
      expect(movies[1].title, 'John Carter');
    });

    test('returns a movie when its ID exists', () async {
      final repository = MovieRepository();

      final movie = await repository.getMovieById('the-intern');

      expect(movie, isNotNull);
      expect(movie!.title, 'The Intern');
    });

    test('returns null when the ID does not exist', () async {
      final repository = MovieRepository();

      final movie = await repository.getMovieById('missing-movie');

      expect(movie, isNull);
    });
  });
}
