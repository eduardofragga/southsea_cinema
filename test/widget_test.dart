import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

    expect(find.text('The Intern'), findsOneWidget);
    expect(find.text('John Carter'), findsOneWidget);
    expect(find.text('Book Tickets'), findsNWidgets(2));
  });
}