import 'package:flutter_test/flutter_test.dart';
import 'package:paracareplus/main.dart';

void main() {
  testWidgets('ParaCarePlus smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ParaCarePlusApp());
    expect(find.text('ParaCarePlus'), findsOneWidget);
  });
}
