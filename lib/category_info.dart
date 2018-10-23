import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/category_progress.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/model.dart';

class CategoryInfo extends StatelessWidget {
  final Category category;

  const CategoryInfo({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: StoreConnector<CategoryState, Category>(
          converter: (store) => store.state.categories
              .firstWhere((filtered) => filtered.id == category.id),
          builder: (context, category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${category.tasks.length} Tasks",
                    style: Theme.of(context).textTheme.subhead),
                SizedBox(height: 4.0),
                Text(category.title,
                    style: Theme.of(context).textTheme.display1),
                SizedBox(height: 12.0),
                CategoryProgress(category: category),
              ],
            );
          }),
    );
  }
}
