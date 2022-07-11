import 'package:flutter/material.dart';

import 'parent_distance/parent_distance_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StackParentExample(),
    );
  }
}

/// For stack example.
class StackParentExample extends StatefulWidget {
  const StackParentExample({super.key});
  @override
  _StackParentExampleState createState() => _StackParentExampleState();
}

class _StackParentExampleState extends State<StackParentExample> {
  List<Widget> movableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: movableItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          movableItems.add(const MoveableStackItem());
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoveableStackItem extends StatefulWidget {
  const MoveableStackItem({Key? key}) : super(key: key);

  @override
  State<MoveableStackItem> createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: ParentDistance(
          skipParent: 2,
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
