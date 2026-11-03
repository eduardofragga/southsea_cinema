
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

void main() {
  testWidgets('Basket displays tickets and total', (WidgetTester tester) async {
    final basket = BasketRepository();

    final movie = await tester.runAsync(() async {
      return (await MovieRepository().getMovies()).first;
    });

    basket.addTickets(movie!, 2);

    await tester.pumpWidget(
      MaterialApp(
        home: BasketView(basketRepository: basket),
      ),
    );

    expect(find.text('The Intern'), findsOneWidget);
    expect(find.text('2 ticket(s) × £7.50'), findsOneWidget);
    expect(find.text('£15.00'), findsNWidgets(2));
  });

  testWidgets('Removing tickets updates the basket',
      (WidgetTester tester) async {
    final basket = BasketRepository();

    final movie = await tester.runAsync(() async {
      return (await MovieRepository().getMovies()).first;
    });

    basket.addTickets(movie!, 2);

    await tester.pumpWidget(
      MaterialApp(
        home: BasketView(basketRepository: basket),
      ),
    );

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(basket.getTickets().isEmpty, true);
  });

  testWidgets('Checkout clears the basket', (WidgetTester tester) async {
    final basket = BasketRepository();

    final movie = await tester.runAsync(() async {
      return (await MovieRepository().getMovies()).first;
    });

    basket.addTickets(movie!, 2);

    await tester.pumpWidget(
      MaterialApp(
        home: BasketView(basketRepository: basket),
      ),
    );

    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();

    expect(find.text('Checkout complete!'), findsOneWidget);
    expect(basket.getTickets().isEmpty, true);
    expect(basket.getTotal(), 0.0);
  });
}
