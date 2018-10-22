import 'package:flutter/material.dart';
import 'package:flutter_todo/model.dart';

class DataProvider {
  List<Category> get list => [
        Category(Icons.person, Colors.blue, "Personal", [
          Task("Task", false),
        ]),
        Category(Icons.content_paste, Colors.orange, "Work", []),
      ];
}
