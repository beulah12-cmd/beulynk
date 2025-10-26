// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:blynk/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BlynkApp());

    // Verify that the landing page loads with BEULYNK title
    expect(find.text('BEULYNK'), findsWidgets);

    // Verify Sign In and Sign Up buttons exist
    expect(find.text('Sign In'), findsWidgets);
    expect(find.text('Sign Up'), findsWidgets);
  });

  testWidgets('Navigation to Sign In page works', (WidgetTester tester) async {
    await tester.pumpWidget(const BlynkApp());

    // Find and tap the first Sign In button (in the app bar)
    final signInButton = find.text('Sign In').first;
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // Verify we're on the sign in page
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
