part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {}

class EditTodoState extends TodoState {
  final Todo todo;
  const EditTodoState(this.todo);
}

class MyTodoState extends TodoState {
  final List<Todo> todos;
  const MyTodoState({required this.todos});
}

class NewTodoState extends TodoState {}
