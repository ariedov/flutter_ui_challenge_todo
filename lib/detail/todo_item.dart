import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/model.dart';

class TodoItem extends StatelessWidget {
  final Category category;
  final Task task;

  const TodoItem({Key key, this.task, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: StoreConnector<CategoryState, ValueChanged>(
                  converter: (store) =>
                      (value) => store.dispatch(ChangeTaskStatus(category, task, value)),
                  builder: (context, action) => Checkbox(
                        onChanged: (value) => action(value),
                        value: task.done,
                        activeColor: Colors.black12,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                task.name,
                style: TextStyle(
                  color: task.done ? Colors.black38 : Colors.black87,
                  fontSize: 18.0,
                  decoration: task.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
          height: 20.0,
          child: _buildDeleteButton(),
        ),
      ],
    );
  }

  _buildDeleteButton() {
    if (!task.done) {
      return SizedBox();
    }
    return StoreConnector<CategoryState, VoidCallback>(
      converter: (state) => () => state.dispatch(RemoveTask(category, task)),
      builder: (context, action) => IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(
              Icons.delete,
              color: Colors.black38,
            ),
            onPressed: task.done ? action : null,
          ),
    );
  }
}
