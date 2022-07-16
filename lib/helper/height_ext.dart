import 'package:flutter/widgets.dart';

extension ResponsiveHight on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );

  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}
