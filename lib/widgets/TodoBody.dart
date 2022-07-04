import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoBody extends StatelessWidget {
  final TextEditingController bodyController;

  const TodoBody({super.key, required this.bodyController});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "plase enter the TODO body";
          }
          return null;
        },
        maxLines: 15,
        decoration: InputDecoration(
          labelText: "Todo Body",
          border: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        controller: bodyController,
      ),
    );
  }
}
