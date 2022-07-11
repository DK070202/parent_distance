import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderParentDistance extends RenderProxyBox {
  RenderParentDistance(int skipCount) : _skipParent = skipCount;

  int _skipParent;

  int get skipParent => _skipParent;
  set skipParent(int count) {
    _skipParent = count;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    /// For skipping parent for adjusting targeted parent.
    AbstractNode? node = parent;
    for (var i = 0; i < skipParent; i++) {
      node = node!.parent!;
    }

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (node is RenderBox) {
      /// Size of parent.
      final sizeOfParent = node.size;

      /// Calculate the parent position globally.
      final parentsOffsetGlobally = node.localToGlobal(Offset.zero);

      /// From left side to child.
      context.canvas.drawLine(
          Offset(
              parentsOffsetGlobally.dx, offset.dy + (child!.size.height / 2)),
          Offset(offset.dx, offset.dy + (child!.size.height / 2)),
          paint);

      /// From right to left.
      context.canvas.drawLine(
          Offset(parentsOffsetGlobally.dx + sizeOfParent.width,
              offset.dy + (child!.size.height / 2)),
          Offset(offset.dx + child!.size.width,
              offset.dy + (child!.size.height / 2)),
          paint);

      /// From top to child.
      context.canvas.drawLine(
          Offset(offset.dx + (child!.size.width / 2), parentsOffsetGlobally.dy),
          Offset(offset.dx + (child!.size.width / 2), offset.dy),
          paint);

      /// From bottom to child.
      context.canvas.drawLine(
          Offset(offset.dx + (child!.size.width / 2),
              parentsOffsetGlobally.dy + sizeOfParent.height),
          Offset(offset.dx + (child!.size.width / 2),
              offset.dy + child!.size.height),
          paint);
    }

    context.paintChild(child!, offset);
  }
}
