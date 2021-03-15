import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Create a new todo", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('NEW TODO'), findsOneWidget);

    Finder textField = find.byType(TextFormField);
    String description = 'This is a new todo';
    await tester.tap(textField);
    await tester.enterText(textField, description);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);
  });

  testWidgets("Add and Remove a todo", (WidgetTester tester) async {
    app.main();
    String description = 'Todo to remove';
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('NEW TODO'), findsOneWidget);

    Finder textField = find.byType(TextFormField);
    await tester.tap(textField);
    await tester.enterText(textField, description);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);

    await tester.drag(find.text(description), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text(description), findsNothing);
  });

  testWidgets("Add and Edit a todo's description", (WidgetTester tester) async {
    app.main();
    String description = 'Todo to remove';
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('NEW TODO'), findsOneWidget);

    Finder textField = find.byType(TextFormField);
    await tester.tap(textField);
    await tester.enterText(textField, description);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text(description), findsOneWidget);

    await tester.drag(find.text(description), Offset(-300, 0));
    await tester.pumpAndSettle();

    String editedText = 'Edited todo';
    await tester.tap(textField);
    await tester.enterText(textField, editedText);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text(editedText), findsOneWidget);
  });

  testWidgets("Add a todo and Change it's completeness", (WidgetTester tester) async {
    app.main();
    String description = 'Todo to set as complete';
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('NEW TODO'), findsOneWidget);

    Finder textField = find.byType(TextFormField);
    await tester.tap(textField);
    await tester.enterText(textField, description);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text(description), findsOneWidget);
    //find.byType(Container)) as Container
    expect((tester.firstWidget(
      find.byType(CheckboxListTile)
    ) as CheckboxListTile).value, false);

    await tester.tap(find.text(description));
    await tester.pumpAndSettle();
    expect((tester.firstWidget(
        find.byType(CheckboxListTile)
    ) as CheckboxListTile).value, true);
  });
}