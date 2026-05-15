import 'package:flutter_test/flutter_test.dart';
import 'package:s_mate/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SMateApp());
    expect(find.byType(SMateApp), findsOneWidget);
  });
}
