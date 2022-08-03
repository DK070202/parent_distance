import 'package:flutter/material.dart';
import 'package:parent_distance/parent_box/rander_parent_box.dart';

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
  RenderParentBox createRenderObject(BuildContext context) {
    return RenderParentBox();
  }
}
