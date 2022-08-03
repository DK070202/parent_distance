import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderParentBox extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    /// A loop that paints all parent box.
    AbstractNode? node = parent;
    while (node != null) {
      if (node is RenderBox) {
        Offset someDistance =
            node.localToGlobal(offset - localToGlobal(Offset.zero));
        context.canvas.drawRect(
            Offset(someDistance.dx, someDistance.dy) & node.size, paint);
      }
      node = node.parent;
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}
