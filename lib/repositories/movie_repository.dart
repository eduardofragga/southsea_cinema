import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      const Movie(
        id: 'the-intern',
        title: 'The Intern',
        ageRating: '12A',
        synopsis:
            'A seventy-year-old man becomes an intern at an online fashion company.',
        screeningTime: '18:30',
        runtime: '1h 55min',
        ticketPrice: 7.50,
        posterPath: 'assets/images/theintern.jpg',
      ),
      const Movie(
        id: 'john-carter',
        title: 'John Carter',
        ageRating: '12A',
        synopsis:
            "Civil War veteran John's resistance to join the army leads him to trouble. He eventually finds himself in a situation he did not expect.",
        screeningTime: '20:00',
        runtime: '2h 12min',
        ticketPrice: 7.50,
        posterPath: 'assets/images/johncarter.jpg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }
}