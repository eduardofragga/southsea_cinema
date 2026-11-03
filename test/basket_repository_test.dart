
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  test('Adding tickets updates the basket', () {
    final basket = BasketRepository();
    final movie = MovieRepository().getMovies().first;

    basket.addTickets(movie, 2);

    expect(basket.getTickets()[movie], 2);
    expect(basket.getTotal(), 15.00);
  });

  test('Removing tickets updates the basket', () {
    final basket = BasketRepository();
    final movie = MovieRepository().getMovies().first;

    basket.addTickets(movie, 2);
    basket.removeTickets(movie);

    expect(basket.getTickets().isEmpty, true);
    expect(basket.getTotal(), 0.0);
  });

  test('Clearing the basket removes all tickets', () {
    final basket = BasketRepository();
    final movies = MovieRepository().getMovies();

    basket.addTickets(movies[0], 2);
    basket.addTickets(movies[1], 1);
    basket.clearBasket();

    expect(basket.getTickets().isEmpty, true);
    expect(basket.getTotal(), 0.0);
  });
}
