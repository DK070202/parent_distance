import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderParentDistance extends RenderProxyBox {
  RenderParentDistance(int skipCount, Color color)
      : _skipParent = skipCount,
        _color = color;

  int _skipParent;
  set skipParent(int count) {
    _skipParent = count;
    markNeedsPaint();
  }

  Color _color;
  set color(Color color) {
    _color = color;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    print(" ${localToGlobal(Offset.zero)}this is offset:$offset");

    /// For skipping parent for adjusting targeted parent.
    AbstractNode? node = parent;
    for (var i = 0; i < _skipParent; i++) {
      node = node!.parent!;
    }

    final paint = Paint()
      ..color = _color
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

      /// For creating rect around child and parent-----------------------------
      context.canvas.drawRect(parentsOffsetGlobally & sizeOfParent, paint);
      context.canvas.drawRect(offset & child!.size, paint);

      final ui.Paragraph paragraph = paintParagraph(
        'Y:${(offset.dy - parentsOffsetGlobally.dy).floorToDouble()} X: ${(offset.dx - parentsOffsetGlobally.dx).floorToDouble()}',
      );

      context.canvas.drawRect(
          (Offset(offset.dx, offset.dy - paragraph.height)) &
              ui.Size(paragraph.longestLine, paragraph.height),
          paint);

      context.canvas.drawParagraph(
        paragraph,
        Offset(offset.dx, offset.dy - paragraph.height),
      );
    }
  }

  ui.Paragraph paintParagraph(String text) {
    final textStyle = ui.TextStyle(
      color: Colors.black,
      fontSize: 10,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);
    final localConstraints =
        ui.ParagraphConstraints(width: constraints.biggest.width);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(localConstraints);
    return paragraph;
  }
}
