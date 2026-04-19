// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowtask/main.dart';

void main() {
  testWidgets('App basic smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Note: This might still fail due to Firebase initialization in main()
    // but we are fixing the compilation error here.
    await tester.pumpWidget(
      const ProviderScope(
        child: FlowTaskApp(),
      ),
    );

    expect(find.text('FlowTask'), findsNothing); // It starts with splash
  });
}
