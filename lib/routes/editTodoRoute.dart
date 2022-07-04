import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/todo_bloc.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/widgets/TodoBody.dart';

import '../widgets/TodoTitle.dart';

class EditTodoRoute extends StatefulWidget {
  final bool newTodo;
  // final Todo todo;
  // final int index;

  EditTodoRoute({
    Key? key,
    required this.newTodo,
    // required this.todo,
    // required this.index,
  }) : super(key: key);

  @override
  State<EditTodoRoute> createState() => _EditTodoRouteState();
}

class _EditTodoRouteState extends State<EditTodoRoute> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.newTodo ? 'New TODO' : 'Add TODO',
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TodoTitlte(
                  titleController: _titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TodoBody(
                  bodyController: _bodyController,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        label: Text(widget.newTodo ? "ADD" : "UPDATE"),
        icon: Icon(Icons.add),
        onPressed: () {
          print("Clicked");
          if (_formkey.currentState!.validate()) {
            widget.newTodo
                ? BlocProvider.of<TodoBloc>(context).add(
                    AddTodoEvent(
                        title: _titleController.text,
                        description: _bodyController.text),
                  )
                : BlocProvider.of<TodoBloc>(context).add(TodoEditEvent(
                    title: _titleController.text,
                    description: _bodyController.text,
                    index: 0));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
