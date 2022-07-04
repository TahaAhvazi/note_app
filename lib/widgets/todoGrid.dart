import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/todo_bloc.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/routes/editTodoRoute.dart';
import 'package:note_app/widgets/totoCart.dart';

class TodoGrid extends StatelessWidget {
  final MyTodoState state;
  const TodoGrid({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: double.infinity,
      child: GridView.builder(
        itemCount: state.todos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 100,
        ),
        itemBuilder: (context, index) {
          final todo = state.todos[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTodoRoute(
                    newTodo: true,
                  ),
                ),
              );
            },
            child: GestureDetector(
              onDoubleTap: () {
                BlocProvider.of<TodoBloc>(context)
                    .add(DeleteTodoEvent(index: index));
              },
              child: TodoCart(
                title: todo.title,
                description: todo.description,
              ),
            ),
          );
        },
      ),
    );
  }
}
