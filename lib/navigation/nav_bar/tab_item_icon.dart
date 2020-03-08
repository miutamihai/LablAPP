import 'package:flutter/material.dart';

/// It is used to define the tab items
class TabItemIcon {
  final Color startColor;
  final Color endColor;
  final IconData iconData;
  final Color curveColor;
  double size;

  TabItemIcon({
    this.curveColor = const Color(0xff2A0835),
    this.startColor = Colors.black,
    this.endColor = Colors.white,
    this.size = 30,
    @required this.iconData,
  });
}
