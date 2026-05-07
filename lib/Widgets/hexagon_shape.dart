import 'package:flutter/material.dart';

class HexagonShape extends ShapeBorder {
  const HexagonShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double width = rect.width;
    final double height = rect.height;
    final double side = width / 2;
    final Path path = Path();
    path.moveTo(rect.left + side, rect.top);
    path.lineTo(rect.right, rect.top + height * 0.25);
    path.lineTo(rect.right, rect.top + height * 0.75);
    path.lineTo(rect.left + side, rect.bottom);
    path.lineTo(rect.left, rect.top + height * 0.75);
    path.lineTo(rect.left, rect.top + height * 0.25);
    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => const HexagonShape();
}