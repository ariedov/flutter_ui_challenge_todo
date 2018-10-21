import 'package:flutter/material.dart';
import 'package:flutter_todo/category_card.dart';
import 'package:flutter_todo/circular_image.dart';
import 'package:flutter_todo/model.dart';
import 'package:snaplist/snaplist.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size itemSize = Size(280.0, 350.0);

    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = (screenWidth - itemSize.width) / 2;
    return Container(
      color: Colors.orange,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 32.0,
                      ),
                      CircularImage(
                        path: "assets/images/profile_image.jpg",
                        width: 50.0,
                        height: 60.0,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text("Hello, Jane.",
                          style: Theme.of(context).textTheme.body1),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text("Looks like feel good.",
                          style: Theme.of(context).textTheme.body2),
                      Text("You have 3 tasks to do today.",
                          style: Theme.of(context).textTheme.body2),
                    ],
                  ),
                ),
                // Toobar,

                SizedBox(height: 48.0),
                Padding(
                  padding: EdgeInsets.only(left: horizontalPadding),
                  child: Text(
                    "today | 23 september".toUpperCase(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Container(
                    child: SnapList(
                      alignment: Alignment.topCenter,
                      separatorProvider: (_) => Size.fromWidth(12.0),
                      sizeProvider: (_) => itemSize,
                      padding: EdgeInsets.only(
                          left: horizontalPadding, right: horizontalPadding),
                      count: 3,
                      builder: (context, data) {
                        final position = data.current;
                        return CategoryCard(
                          size: itemSize,
                          category: Category(Icons.content_paste, Colors.orange, "Fun", []),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
