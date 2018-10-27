import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/category_icon.dart';
import 'package:flutter_todo/category_info.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/detail/todo_item.dart';
import 'package:flutter_todo/model.dart';

class TaskList extends StatefulWidget {
  final Category category;

  const TaskList({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> with TickerProviderStateMixin {
  AnimationController _revealAnimation;

  Tween<double> opacityTween = Tween(begin: 0.0, end: 1.0);
  List<double> itemOpacities;

  @override
  void initState() {
    itemOpacities = widget.category.tasks.map((_) => 0.0).toList();

    _revealAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {
              for (int i = 0; i < widget.category.tasks.length; ++i) {
                final animation = CurvedAnimation(
                    parent: _revealAnimation,
                    curve: Interval(i / widget.category.tasks.length, 1.0,
                        curve: Curves.ease));
                itemOpacities[i] = opacityTween.evaluate(animation);
              }
            });
          });

    _revealAnimation.forward(from: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: StoreConnector<CategoryState, List<Task>>(
                converter: (store) => store.state.categories
                    .firstWhere((category) => category.id == widget.category.id)
                    .tasks,
                builder: (context, tasks) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];
                      return Opacity(
                          opacity: itemOpacities[index],
                          child:
                              TodoItem(category: widget.category, task: task));
                    },
                    itemCount: tasks.length,
                  );
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _revealAnimation.dispose();
    super.dispose();
  }
}
