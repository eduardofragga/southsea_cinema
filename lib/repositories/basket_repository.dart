
import 'package:southsea_cinema/models/movie.dart';

class BasketRepository {
  final Map<Movie, int> _tickets = {};

  void addTickets(Movie movie, int quantity) {
    for (final entry in _tickets.entries) {
      if (entry.key == movie) {
        _tickets[movie] = entry.value + quantity;
        return;
      }
    }

    _tickets[movie] = quantity;
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
