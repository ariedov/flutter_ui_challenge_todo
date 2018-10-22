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

  RevealData revealData;

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

                        final cardKey = GlobalKey();
                        return CategoryCard(
                          key: cardKey,
                          size: itemSize,
                          category: provider.list[position],
                          onPressed: () => Navigator.of(context).push(
                                PageRouteBuilder(pageBuilder:
                                    (BuildContext context, Animation animation,
                                        Animation secondaryAnimation) {
                                  return DetailScreen(
                                      category: provider.list[position]);
                                }, transitionsBuilder: (BuildContext context,
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

  _captureRevealData(GlobalKey key) {
    if (revealData != null) {
      return revealData;
    }

    BuildContext context = key.currentContext;
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

class ScreenTransition extends AnimatedWidget {
  final Widget screen;
  final Animation<double> animation;
  final RevealData revealData;

  const ScreenTransition({
    Key key,
    this.screen,
    this.animation,
    this.revealData,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    print("Animation value: ${animation.value}");
    final cropRect = Rect.fromLTRB(
        revealData.leftTween.evaluate(animation),
        revealData.topTween.evaluate(animation),
        revealData.rightTween.evaluate(animation),
        revealData.bottomTween.evaluate(animation));
    return ClipRect(
      child: screen,
      clipper: TransitionClipper(cropRect),
    );
  }
}

class TransitionClipper extends CustomClipper<Rect> {
  final Rect clip;

  TransitionClipper(this.clip);

  @override
  Rect getClip(Size size) => clip;

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class RevealData {
  final Rect initial;
  final Rect expected;

  RevealData(this.initial, this.expected);

  Tween<double> get leftTween => Tween(begin: initial.left, end: expected.left);
  Tween<double> get topTween => Tween(begin: initial.top, end: expected.top);
  Tween<double> get rightTween =>
      Tween(begin: initial.right, end: expected.right);
  Tween<double> get bottomTween =>
      Tween(begin: initial.bottom, end: expected.bottom);
}
