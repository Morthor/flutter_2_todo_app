import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:flutter_2_todo_app/main.dart';
import 'package:flutter_2_todo_app/todo_model.dart';

void main() {
  group('Variables', (){
    test('Item list should start empty', () {
      final itemListWidget = ItemListWidgetState();
      expect(itemListWidget.items.length, 0);
    });
  });

  group('Actions', (){
    test('Add Todo to List', (){
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      final String description = 'New item';
      expect(itemListWidget.items.length, 0);
      itemListWidget.addTodoToList(description);
      expect(itemListWidget.items.length, 1);
      expect(itemListWidget.items.first.description, description);
    });
  });

  group('Operations', (){
    test('Add new item', () {
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      final String description = 'New item';
      expect(itemListWidget.items.length, 0);
      itemListWidget.addItem(Todo(description));
      expect(itemListWidget.items.length, 1);
      expect(itemListWidget.items.first.description, description);
    });

    test('Remove item', () {
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      expect(itemListWidget.items.length, 0);
      itemListWidget.addTodoToList('New item');
      expect(itemListWidget.items.length, 1);
      itemListWidget.removeItem(itemListWidget.items.first);
      expect(itemListWidget.items.length, 0);
    });

    test('Update Item Completeness', () {
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      final String description = 'New item';
      final Todo item = Todo(description);
      expect(item.complete, false);
      expect(itemListWidget.items.length, 0);
      itemListWidget.addItem(item);
      expect(itemListWidget.items.length, 1);
      expect(itemListWidget.items.first.complete, false);
      itemListWidget.updateItemCompleteness(item);
      expect(itemListWidget.items.first.complete, true);
      expect(item.complete, true);
    });

    test('Update Item Description', () {
      final ItemListWidgetState itemListWidget = ItemListWidgetState();
      final String description = 'New item';
      final String newDescription = 'New item';
      final Todo item = Todo(description);
      expect(item.complete, false);
      expect(itemListWidget.items.length, 0);
      itemListWidget.addItem(item);
      expect(itemListWidget.items.length, 1);
      expect(itemListWidget.items.first.description, description);
      itemListWidget.updateItemDescription(item, newDescription);
      expect(itemListWidget.items.first.description, newDescription);
      expect(item.description, newDescription);
    });
  });
}