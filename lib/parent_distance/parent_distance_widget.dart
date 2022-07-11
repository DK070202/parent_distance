import 'package:flutter/material.dart';

import 'render_parent_distance_widget.dart';

class ParentDistance extends SingleChildRenderObjectWidget {
  const ParentDistance({
    super.key,
    super.child,
    this.skipParent = 0,
  });
  final int skipParent;

  @override
  RenderParentDistance createRenderObject(BuildContext context) {
    return RenderParentDistance(skipParent);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderParentDistance renderObject) {
    renderObject.skipParent = skipParent;
  }
}
