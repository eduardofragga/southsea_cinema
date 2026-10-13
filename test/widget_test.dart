import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

    expect(find.text('The Intern'), findsOneWidget);
    expect(find.text('John Carter'), findsOneWidget);
    expect(find.text('Book Tickets'), findsNWidgets(2));
  });

  testWidgets('Booking a movie displays details and order feedback',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

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