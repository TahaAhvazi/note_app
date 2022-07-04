import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoTitlte extends StatelessWidget {
  final TextEditingController titleController;

  const TodoTitlte({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter the TODO totle";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'TODO TITLE',
          border: OutlineInputBorder(),
        ),
        controller: titleController,
      ),
    );
  }
}
