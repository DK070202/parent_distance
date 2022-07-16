import 'package:flutter/material.dart';

import 'render_parent_distance_widget.dart';

class ParentDistance extends SingleChildRenderObjectWidget {
  const ParentDistance({
    super.key,
    super.child,
    this.skipParent = 0,
    this.color = Colors.blue,
  });
  final int skipParent;
  final Color color;

  @override
  RenderParentDistance createRenderObject(BuildContext context) {
    return RenderParentDistance(skipParent, color);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderParentDistance renderObject) {
    renderObject
      ..skipParent = skipParent
      ..color = color;
  }
}
