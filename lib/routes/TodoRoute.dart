import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/todo_bloc.dart';
import 'package:note_app/routes/editTodoRoute.dart';

import '../widgets/todoGrid.dart';

class TodoRoute extends StatelessWidget {
  const TodoRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TODOS"),
        actions: const [
          Icon(
            Icons.settings,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTodoRoute(
                newTodo: true,
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoInitial) {
                  return Container();
                }
                if (state is MyTodoState) {
                  return TodoGrid(state: state);
                }
                if (state is TodoLoadingState) {
                  return Container();
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
