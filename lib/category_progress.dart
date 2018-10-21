import 'package:flutter/material.dart';

class CategoryProgress extends StatelessWidget {
  final Color color;
  const CategoryProgress({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 3.0,
            child: LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.black12,
              valueColor: AlwaysStoppedAnimation(color),
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
    );
  }
}
