import 'package:flutter_todo/model.dart';

class CategoryState {
  final List<Category> categories;

  CategoryState(this.categories);
}

CategoryState stateReducer(CategoryState oldState, dynamic action) {
  if (action is ChangeTaskStatus) {
    return CategoryState(oldState.categories.map((category) {
      if (category.id == action.category.id) {
        return Category(
            category.id,
            category.icon,
            category.color,
            category.title,
            category.tasks.map((task) {
              if (task.id == action.task.id) {
                return Task(task.id, task.name, action.status);
              }
              return task;
            }).toList());
      }
      return category;
    }).toList());
  }

  if (action is RemoveTask) {
    return CategoryState(oldState.categories.map((category) {
      if (category.id == action.category.id) {
        category.tasks.removeWhere((task) => task.id == action.task.id);
        return Category(category.id, category.icon, category.color,
            category.title, category.tasks);
      }
      return category;
    }).toList());
  }

  if (action is AddTask) {
    return CategoryState(
      oldState.categories.map((category) {
        if (category.id == action.category.id) {
          int id = category.tasks.length + 1;
          category.tasks.insert(0, Task(id, action.taskTitle, false));
        }
        return category;
      }).toList(),
    );
  }

  throw "No such action $action";
}

class ChangeTaskStatus {
  final Category category;
  final Task task;
  final bool status;

  ChangeTaskStatus(this.category, this.task, this.status);
}

class RemoveTask {
  final Category category;
  final Task task;

  RemoveTask(this.category, this.task);
}

class AddTask {
  final Category category;
  final String taskTitle;

  AddTask(this.category, this.taskTitle);
}
