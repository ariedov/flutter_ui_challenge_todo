import 'package:flutter/material.dart';

class Category {
  
  final IconData icon;
  final Color color;
  final String title;
  final List<Task> tasks;

  Category(this.icon, this.color, this.title, this.tasks);
}

class Task {
  final String name;
  final bool done;

  Task(this.name, this.done);
}