// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/model.dart';

void main() {
  test("test new task", () {
    final category = Category(0, Icons.ac_unit, Colors.black, "Title", []);

    final initialState = CategoryState([category]);

    final newState = stateReducer(initialState, AddTask(category, "New Task"));
    expect(newState.categories[0].tasks.length, 1);
    expect(newState.categories[0].tasks[0].name, "New Task");
    expect(newState.categories[0].tasks[0].done, false);
  });

  test("test remove task", () {
    final task = Task(0, "Name", true);
    final category = Category(0, Icons.ac_unit, Colors.black, "Title", [task]);

    final initialState = CategoryState([category]);

    final newState = stateReducer(initialState, RemoveTask(category, task));
    expect(newState.categories[0].tasks.length, 0);
  });

  test("test mark task done", () {
    final task = Task(0, "Name", false);
    final category = Category(0, Icons.ac_unit, Colors.black, "Title", [task]);

    final initialState = CategoryState([category]);

    final newState = stateReducer(initialState, ChangeTaskStatus(category, task, true));
    expect(newState.categories[0].tasks.length, 1);
    expect(newState.categories[0].tasks[0].done, true);
  });

  test("test mark task undone", () {
    final task = Task(0, "Name", true);
    final category = Category(0, Icons.ac_unit, Colors.black, "Title", [task]);

    final initialState = CategoryState([category]);

    final newState = stateReducer(initialState, ChangeTaskStatus(category, task, false));
    expect(newState.categories[0].tasks.length, 1);
    expect(newState.categories[0].tasks[0].done, false);
  });
}
