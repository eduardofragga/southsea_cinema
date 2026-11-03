import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Profile loads, saves and reopens', (tester) async {
    final preferences = SharedPreferencesAsync();

    // Save an example profile.
    await preferences.setString('profile_name', 'Jamie Smith');
    await preferences.setString('profile_email', 'jamie@example.com');
    await preferences.setString('profile_phone', '07111111111');
    await preferences.setString('profile_address', '10 High Street');
    await preferences.setBool('profile_email_news', false);

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsView(preferences: preferences),
      ),
    );
    await tester.pumpAndSettle();

    // Check that the saved profile loads.
    var fields = tester
        .widgetList<TextFormField>(
          find.byType(TextFormField),
        )
        .toList();

    expect(fields[0].controller!.text, 'Jamie Smith');
    expect(fields[1].controller!.text, 'jamie@example.com');
    expect(fields[2].controller!.text, '07111111111');
    expect(fields[3].controller!.text, '10 High Street');

    expect(
      tester
          .widget<CheckboxListTile>(
            find.byType(CheckboxListTile),
          )
          .value,
      false,
    );

    // Edit the profile.
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Taylor Reed',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'taylor@example.com',
    );

    await tester.ensureVisible(find.byType(CheckboxListTile));
    await tester.tap(find.byType(CheckboxListTile));

    await tester.ensureVisible(find.text('Save Profile'));
    await tester.tap(find.text('Save Profile'));
    await tester.pumpAndSettle();

    // Check the saved changes.
    expect(find.text('Profile saved'), findsOneWidget);
    expect(
      await preferences.getString('profile_name'),
      'Taylor Reed',
    );
    expect(
      await preferences.getString('profile_email'),
      'taylor@example.com',
    );
    expect(
      await preferences.getBool('profile_email_news'),
      true,
    );

    // Close and reopen Settings.
    await tester.pumpWidget(const SizedBox.shrink());

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsView(preferences: preferences),
      ),
    );
    await tester.pumpAndSettle();

    // Check that the changes are remembered.
    fields = tester
        .widgetList<TextFormField>(
          find.byType(TextFormField),
        )
        .toList();

    expect(fields[0].controller!.text, 'Taylor Reed');
    expect(fields[1].controller!.text, 'taylor@example.com');

    expect(
      tester
          .widget<CheckboxListTile>(
            find.byType(CheckboxListTile),
          )
          .value,
      true,
    );
  });
}
