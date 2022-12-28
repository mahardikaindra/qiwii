// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qiwii/main.dart';

void main() {
  testWidgets('Codelab smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());

    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    expect(textWidgets.length, greaterThan(2));

    expect(textWidgets.last.data, 'Startup Name Generator');

    final wordPairRegExp = RegExp(r'^[A-Z]\w*[A-Z]\w*$');
    final isWordPair = predicate<String>((s) => wordPairRegExp.hasMatch(s));
    for (final widget in textWidgets.take(textWidgets.length - 1)) {
      expect(widget.data, isWordPair);
    }

    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MaterialApp(home: MyApp()));

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels for android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text (18 point and above regular)
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
