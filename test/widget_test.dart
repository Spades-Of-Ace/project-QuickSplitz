import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:project/screen/landing_page.dart';
import 'package:quicksplitz/screen/landing_page.dart'; // Update path if needed

void main() {
  testWidgets('Landing page displays logo, welcome text, and button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LandingPage()));

    // Check if logo is displayed
    expect(find.byType(Image), findsOneWidget);

    // Check if welcome text is displayed
    expect(find.text('Welcome to QuickSplitz'), findsOneWidget);

    // Check if button is displayed
    expect(find.text('Get Splitzzing'), findsOneWidget);
  });
}
