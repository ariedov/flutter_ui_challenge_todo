import 'package:flutter/material.dart';
import 'package:flutter_todo/category_icon.dart';
import 'package:flutter_todo/category_info.dart';
import 'package:flutter_todo/detail/todo_item.dart';
import 'package:flutter_todo/model.dart';

class DetailScreen extends StatefulWidget {
  final Category category;

  const DetailScreen({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: "categoryIcon${widget.category.title}",
                child: CategoryIcon(
                  icon: widget.category.icon,
                  color: widget.category.color,
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Hero(
                  tag: "categoryInfo${widget.category.title}",
                  child: CategoryInfo(category: widget.category)),
              SizedBox(
                height: 24.0,
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final task = widget.category.tasks[index];
                      return TodoItem(
                        task: task,
                        taskStateChanged: (state) {
                          setState(() {
                            widget.category.tasks[index] =
                                Task(task.name, state);
                          });
                        },
                        taskRemoved: () {
                          setState(() {
                            widget.category.tasks.removeAt(index);
                          });
                        },
                      );
                    },
                    itemCount: widget.category.tasks.length,
                  ),
                  duration: Duration(milliseconds: 300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
