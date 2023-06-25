import 'package:flutter/material.dart';
class ToDo {
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id: '1', todotext: 'This is the first comment'),

    ];
  }
}


