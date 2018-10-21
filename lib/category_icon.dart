import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  
  final IconData icon;
  final Color color;

  const CategoryIcon({Key key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12, style: BorderStyle.solid),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
