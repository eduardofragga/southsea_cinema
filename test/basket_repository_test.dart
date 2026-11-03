
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
}
