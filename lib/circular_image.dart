import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final double width;
  final double height;
  final String path;

  CircularImage({
    Key key,
    @required this.path,
    @required this.width,
    @required this.height,
  }) : super(key: key) {
    assert(this.path != null);
    assert(this.width != null);
    assert(this.height != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(path),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, 5.0),
            blurRadius: 5.0,
          )
        ],
      ),
      width: width,
      height: height,
    );
  }
}
