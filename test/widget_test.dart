import 'package:flutter_test/flutter_test.dart';

import 'package:jamia_mobile/main.dart';

void main() {
  testWidgets('App starts on the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const JamiaApp());

    expect(find.text('JAMIA'), findsOneWidget);
    expect(find.text('Welcome to JAMIA'), findsOneWidget);
  });
}
