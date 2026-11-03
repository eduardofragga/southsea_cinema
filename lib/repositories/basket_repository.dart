
import 'package:southsea_cinema/models/movie.dart';

class BasketRepository {
  final Map<Movie, int> _tickets = {};

  void addTickets(Movie movie, int quantity) {
    _tickets[movie] = (_tickets[movie] ?? 0) + quantity;
  }

  void removeTickets(Movie movie) {
    _tickets.remove(movie);
  }

  void clearBasket() {
    _tickets.clear();
  }

  Map<Movie, int> getTickets() {
    return Map.unmodifiable(_tickets);
  }

  double getTotal() {
    double total = 0;

    _tickets.forEach((movie, quantity) {
      total += movie.ticketPrice * quantity;
    });

    return total;
  }
}
