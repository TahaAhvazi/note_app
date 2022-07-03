import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/services/todoService.dart';

import '../models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> _todos = [];
  final TodoDataBase _todoDataBase;
  TodoBloc(this._todoDataBase) : super(TodoInitial());
  @override
  // TODO: implement stream
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoInitialEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is AddTodoEvent) {
      yield* _mapTodoAddEventToState(
          title: event.title, description: event.description);
    }
    if (event is TodoEditEvent) {
      yield* _mapTodoEditEventToState(
          index: event.index,
          title: event.title,
          description: event.description);
    }
    if (event is DeleteTodoEvent) {
      yield* _mapTodoDeleteEventToState(index: event.index);
    }
  }

  Stream<TodoState> _mapInitialEventToState() async* {
    yield TodoLoadingState();

    await _getTodos();

    yield MyTodoState(todos: _todos);
  }

  Future<void> _getTodos() async {
    await _todoDataBase.getTodos().then((value) {
      _todos = value;
    });
  }

  Stream<TodoState> _mapTodoAddEventToState(
      {required String title, required String description}) async* {
    yield TodoLoadingState();
    await _addToDo(title: title, description: description);
    yield MyTodoState(todos: _todos);
  }

  Future<void> _addToDo(
      {required String title, required String description}) async {
    await _todoDataBase.addTodo(
      Todo(title: title, description: description),
    );
    await _getTodos();
  }

  Stream<TodoState> _mapTodoEditEventToState(
      {required String title,
      required String description,
      required int index}) async* {
    yield TodoLoadingState();
    await _updateTodo(
        index: index, newTitle: title, newDescription: description);
    yield MyTodoState(todos: _todos);
  }

  Future<void> _updateTodo({
    required int index,
    required String newTitle,
    required String newDescription,
  }) async {
    await _todoDataBase.updateTodo(
        index,
        Todo(
          title: newTitle,
          description: newDescription,
        ));
    await _getTodos();
  }

  Stream<TodoState> _mapTodoDeleteEventToState({required int index}) async* {
    yield TodoLoadingState();
    await _removeFromTodos(index: index);
    _todos.sort((a, b) {
      var aData = a.title;
      var bData = b.title;
      return aData.compareTo(bData);
    });
    yield MyTodoState(todos: _todos);
  }

  Future<void> _removeFromTodos({required int index}) async {
    await _todoDataBase.deleteTodo(index);
    await _getTodos();
  }
}
