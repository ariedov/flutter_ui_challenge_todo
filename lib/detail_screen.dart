import 'package:flutter/material.dart';
import 'package:flutter_todo/category_icon.dart';
import 'package:flutter_todo/category_info.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
