part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoInitialEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title, description;

  const AddTodoEvent({required this.title, required this.description});
}

class TodoEditEvent extends TodoEvent {
  final String title, description;
  final int index;
  const TodoEditEvent(
      {required this.title, required this.description, required this.index});
}

class DeleteTodoEvent extends TodoEvent {
  final int index;
  const DeleteTodoEvent({required this.index});
}
