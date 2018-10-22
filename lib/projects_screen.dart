import 'package:flutter/material.dart';
import 'package:flutter_todo/category_card.dart';
import 'package:flutter_todo/circular_image.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/detail/detail_screen.dart';
import 'package:snaplist/snaplist.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectsScreen> {

  DataProvider provider = DataProvider();

  ColorTween backgroundTween;
  Color backgroundColor;

  @override
  void initState() {
    backgroundColor = provider.list[0].color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size itemSize = Size(280.0, 350.0);

    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = (screenWidth - itemSize.width) / 2;
    return Container(
      color: backgroundColor,
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
                      progressUpdate: (progress, center, next) {
                        setState(() {
                          backgroundTween = ColorTween(
                              begin: provider.list[center].color,
                              end: provider.list[next].color);
                          backgroundColor =
                              backgroundTween.transform(progress / 100);
                        });
                      },
                      alignment: Alignment.topCenter,
                      separatorProvider: (_) => Size.fromWidth(12.0),
                      sizeProvider: (_) => itemSize,
                      padding: EdgeInsets.only(
                          left: horizontalPadding, right: horizontalPadding),
                      count: provider.list.length,
                      builder: (context, data) {
                        final position = data.current;
                        GlobalKey cardKey = GlobalKey();
                        return CategoryCard(
                          key: cardKey,
                          size: itemSize,
                          category: provider.list[position],
                          onPressed: () => Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return DetailScreen(
                                          category: provider.list[position]);
                                    },
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                        Widget child) {
                                          return ScaleTransition(
                                            alignment: Alignment.bottomCenter,
                                            scale: animation,
                                            child: child,
                                          );
                                        }),
                              ),
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
