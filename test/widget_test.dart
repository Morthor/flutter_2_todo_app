// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_2_todo_app/item_view.dart';
import 'package:flutter_2_todo_app/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_2_todo_app/main.dart';

void main() {
  testWidgets('App start main view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('NO ITEMS'), findsOneWidget);
    expect(
      find.widgetWithIcon(FloatingActionButton, Icons.add),
      findsOneWidget
    );
  });

  group('UI Widgets', (){
    testWidgets(
      'Test if the ItemWidget has a CheckBoxListTile and description composed of the Todo\'s description', (WidgetTester tester) async
    {
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      final String description = 'new todo';
      final itemWidget = ItemWidget(
        item: Todo(description),
        changeTodoCompleteness: itemListWidget.changeTodoCompleteness,
      );
      
      await tester.pumpWidget(
        MaterialAppWrapper(itemWidget)
      );

      expect(find.byType(CheckboxListTile), findsOneWidget);
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('Test that the EmptyList widget has an Icon and a Text description.', (WidgetTester tester) async {
      final emptyList = EmptyList();

      await tester.pumpWidget(
        MaterialAppWrapper(emptyList)
      );

      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.airline_seat_flat), findsOneWidget);
      expect(find.text('NO ITEMS'), findsOneWidget);
    });

    testWidgets('Test that the DismissRemoveBackground has the Delete Icon', (WidgetTester tester) async {
      final backgroundWidget = DismissRemoveBackground();

      await tester.pumpWidget(
        MaterialAppWrapper(backgroundWidget)
      );

      // expect(find.widgetWithIcon(Icon, Icons.delete), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(
        (tester.firstWidget(find.byType(Container)) as Container).color,
        Colors.red
      );
    });

    testWidgets('Test that the DismissEditBackground has the Edit Icon', (WidgetTester tester) async {
      final backgroundWidget = DismissEditBackground();

      await tester.pumpWidget(
        MaterialAppWrapper(backgroundWidget)
      );

      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(
        (tester.firstWidget(find.byType(Container)) as Container).color,
        Colors.blue
      );
    });

    group('Item View', (){
      testWidgets(
        'ItemView as a New Todo view with the "NEW TODO" '
        'title and an empty TextFormField',
        (WidgetTester tester) async
      {
        await tester.pumpWidget(MaterialAppWrapper(ItemView()));

        expect(find.text('NEW TODO'), findsOneWidget);
        expect(find.widgetWithText(TextFormField, ''), findsOneWidget);
        expect(find.widgetWithText(ElevatedButton, 'SUBMIT'), findsOneWidget);
      });

      testWidgets(
        'ItemView as an Edit Todo view with the "EDIT TODO" '
        'title and a TextFormField with a description filled in',
        (WidgetTester tester) async
      {
        String description = 'Existing Todo';
        Todo todo = Todo(description);
        await tester.pumpWidget(MaterialAppWrapper(ItemView(item: todo)));

        expect(find.text('EDIT TODO'), findsOneWidget);
        expect(find.widgetWithText(TextFormField, description), findsOneWidget);
        expect(find.widgetWithText(ElevatedButton, 'SUBMIT'), findsOneWidget);
      });
    });
  });
}

class MaterialAppWrapper extends StatelessWidget {
  final Widget testWidget;

  MaterialAppWrapper(this.testWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: this.testWidget,
      ),
    );
  }
}