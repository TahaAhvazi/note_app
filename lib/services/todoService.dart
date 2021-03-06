import 'package:hive/hive.dart';
import 'package:note_app/models/todo.dart';

class TodoDataBase {
  String boxname = "TODO";
  // ignore: non_constant_identifier_names
  Future<Box> TodoBox() async {
    var box = await Hive.openBox<Todo>(boxname);
    return box;
  }

  Future<List<Todo>> getTodos() async {
    final box = await TodoBox();
    List<Todo> todosList = box.values.toList() as List<Todo>;
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
