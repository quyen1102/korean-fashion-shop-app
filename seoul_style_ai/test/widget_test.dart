import 'package:flutter_test/flutter_test.dart';
import 'package:seoul_style_ai/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SeoulStyleApp());
    expect(find.byType(SeoulStyleApp), findsOneWidget);
  });
}
