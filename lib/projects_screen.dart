import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/category_card.dart';
import 'package:flutter_todo/circular_image.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/detail/detail_screen.dart';
import 'package:flutter_todo/detail_reveal.dart';
import 'package:flutter_todo/model.dart';
import 'package:snaplist/snaplist.dart';

class ProjectsScreen extends StatefulWidget {
  final Color backgroundColor;
  const ProjectsScreen({Key key, this.backgroundColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectsScreen> {
  ColorTween backgroundTween;
  Color backgroundColor;

  RevealData revealData;

  @override
  void initState() {
    backgroundColor = widget.backgroundColor;

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
                      StoreConnector<CategoryState, int>(
                        converter: (store) => store.state.categories.fold(
                            0,
                            (prev, element) =>
                                prev +
                                element.tasks
                                    .where((task) => !task.done)
                                    .length),
                        builder: (context, count) => Text(
                            "You have $count tasks to do today.",
                            style: Theme.of(context).textTheme.body2),
                      ),
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
                    child: StoreConnector<CategoryState, List<Category>>(
                        converter: (store) => store.state.categories,
                        builder: (context, categories) {
                          return SnapList(
                            progressUpdate: (progress, center, next) {
                              setState(() {
                                backgroundTween = ColorTween(
                                    begin: categories[center].color,
                                    end: categories[next].color);
                                backgroundColor =
                                    backgroundTween.transform(progress / 100);
                              });
                            },
                            alignment: Alignment.topCenter,
                            separatorProvider: (position, _) => Size.fromWidth(12.0),
                            sizeProvider: (position, _) => itemSize,
                            padding: EdgeInsets.only(
                                left: horizontalPadding,
                                right: horizontalPadding),
                            count: categories.length,
                            builder: (context, position, _) {
                              final cardKey = GlobalKey();
                              return CategoryCard(
                                key: cardKey,
                                category: categories[position],
                                onPressed: () => Navigator.of(context).push(
                                      PageRouteBuilder(pageBuilder:
                                          (BuildContext context,
                                              Animation animation,
                                              Animation secondaryAnimation) {
                                        return DetailScreen(
                                            category: categories[position]);
                                      }, transitionsBuilder: (BuildContext
                                              context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        RevealData revealData =
                                            _captureRevealData(cardKey);

                                        return ScreenTransition(
                                          animation: animation,
                                          screen: child,
                                          revealData: revealData,
                                        );
                                      }),
                                    ),
                              );
                            },
                            snipDuration: Duration(milliseconds: 300),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _captureRevealData(GlobalKey key) {
    BuildContext context = key.currentContext;
    if (context == null) {
      return revealData;
    }
    final RenderBox box = context.findRenderObject();
    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;

    final screenSize = MediaQuery.of(context).size;

    revealData = RevealData(
        Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height),
        Rect.fromLTWH(0.0, 0.0, screenSize.width, screenSize.height));
    return revealData;
  }
}
