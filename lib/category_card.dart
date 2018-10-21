import 'package:flutter/material.dart';
import 'package:flutter_todo/model.dart';

class CategoryCard extends StatelessWidget {
  final Size size;
  final Category category;

  CategoryCard({
    Key key,
    @required this.size,
    @required this.category,
  }) : super(key: key) {
    assert(this.size != null);
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
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // image
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color,
                    ),
                  ),
                ),
              ),
              Text("${category.tasks.length} Tasks",
                  style: Theme.of(context).textTheme.subhead),
              SizedBox(height: 4.0),
              Text(category.title, style: Theme.of(context).textTheme.display1),
              SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 3.0,
                      child: LinearProgressIndicator(
                        value: 0.3,
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation(category.color),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "30%",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
