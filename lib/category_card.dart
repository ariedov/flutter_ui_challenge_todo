import 'package:flutter/material.dart';
import 'package:flutter_todo/category_icon.dart';
import 'package:flutter_todo/category_info.dart';
import 'package:flutter_todo/model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onPressed;

  CategoryCard({
    Key key,
    @required this.category,
    this.onPressed,
  }) : super(key: key) {
    assert(this.category != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 8.0, offset: Offset(0.0, 12.0))
        ],
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // image
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Hero(
                    tag: "categoryIcon${category.title}",
                    child: CategoryIcon(
                        icon: category.icon, color: category.color),
                  ),
                ),
              ),
              Hero(
                  tag: "categoryInfo${category.title}",
                  child: CategoryInfo(category: category)),
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
