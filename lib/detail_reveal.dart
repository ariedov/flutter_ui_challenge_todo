import 'package:flutter/material.dart';

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
    final cropRect = RRect.fromLTRBXY(
        revealData.leftTween.evaluate(animation),
        revealData.topTween.evaluate(animation),
        revealData.rightTween.evaluate(animation),
        revealData.bottomTween.evaluate(animation),
        16.0 - (animation.value * 16.0),
        16.0 - (animation.value * 16.0));
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0 - (animation.value * 16.0)),
      child: Container(
        color: Colors.white,
        child: Opacity(
          opacity: animation.value,
          child: screen,
        ),
      ),
      clipper: TransitionClipper(cropRect),
    );
  }
}

class TransitionClipper extends CustomClipper<RRect> {
  final RRect clip;

  TransitionClipper(this.clip);

  @override
  RRect getClip(Size size) => clip;

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => true;
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
