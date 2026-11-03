import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/views/home_view.dart';

class TestMovieRepository extends MovieRepository {
  final List<Movie> movies;

  TestMovieRepository(this.movies);

  @override
  Future<List<Movie>> getMovies() async {
    return movies;
  }
}

void main() {
  Future<void> pumpHomeView(WidgetTester tester) async {
    final movies = await tester.runAsync(() async {
      return await MovieRepository().getMovies();
    });

    if (movies == null) {
      throw StateError('Could not load movie data for the test.');
    }

    await tester.pumpWidget(
      MaterialApp(
        home: HomeView(
          basketRepository: BasketRepository(),
          movieRepository: TestMovieRepository(movies),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  testWidgets('Home displays movies', (WidgetTester tester) async {
    await pumpHomeView(tester);

    expect(find.text('The Intern'), findsOneWidget);
    expect(find.text('John Carter'), findsOneWidget);
    expect(find.text('Book Tickets'), findsNWidgets(2));
  });

  testWidgets('Booking a movie displays details and order feedback',
      (WidgetTester tester) async {
    await pumpHomeView(tester);

    expect(find.text('Book Tickets'), findsNWidgets(2));

    await tester.tap(find.text('Book Tickets').first);
    await tester.pumpAndSettle();

    expect(find.text('The Intern'), findsOneWidget);

    expect(
      find.text(
        'A seventy-year-old man becomes an intern at an online fashion company.',
      ),
      findsOneWidget,
    );

    expect(find.text('Runtime: 1h 55min'), findsOneWidget);
    expect(find.text('Ticket price: £7.50'), findsOneWidget);
    expect(find.text('Add to Order'), findsOneWidget);

    await tester.tap(find.text('Add to Order'));
    await tester.pumpAndSettle();

    expect(
      find.text('Added 1 ticket(s) to order.'),
      findsOneWidget,
    );
  });
}
