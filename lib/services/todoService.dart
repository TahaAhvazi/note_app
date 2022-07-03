import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:note_app/models/todo.dart';

class TodoDataBase {
  // ignore: non_constant_identifier_names
  Future<Box> TodoBox() async {
    var box = await Hive.openBox<Todo>("TODO");
    return box;
  }

  Future<List> getTodos() async {
    final box = await TodoBox();
    List todosList = box.values.toList();
    return todosList;
  }

  Future<void> addTodo(Todo todo) async {
    final box = await TodoBox();
    await box.add(todo);
  }

  Future<void> deleteTodo(int index) async {
    final box = await TodoBox();
    await box.delete(index);
  }

  Future<void> deleteAllTodos() async {
    final box = await TodoBox();
    await box.clear();
  }

  Future<void> updateTodo(int index, Todo todo) async {
    final box = await TodoBox();
    box.putAt(index, todo);
  }
}
