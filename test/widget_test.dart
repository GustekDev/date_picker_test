import 'package:date_picker_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Select date test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('No date selected'), findsOneWidget);
    expect(find.text('1998-12-23'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    var dateDialog = find.byType(DatePickerDialog);
    expect(dateDialog, findsOneWidget);
    await tester.tap(find.bySemanticsLabel("Select year"));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(
      of: dateDialog,
      matching: find.byKey(const ValueKey<int>(1998)),
    ));
    await tester.pumpAndSettle();
    for (int i = 0; i < 7; i++) {
      await tester.tap(find.byTooltip("Previous month"));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.descendant(
      of: dateDialog,
      matching: find.bySemanticsLabel("23, Thursday, December 23, 1998"),
    ));
    await tester.tap(
      find.descendant(of: dateDialog, matching: find.text("OK")),
    );

    await tester.pump();
    expect(find.text('No date selected'), findsNothing);
    expect(find.text('1998-12-23'), findsOneWidget);
  });
}
