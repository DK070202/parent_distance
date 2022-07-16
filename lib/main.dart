import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_distance/helper/height_ext.dart';

import 'parent_distance/parent_distance_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SimpleTextLayout(),
    );
  }
}

class SimpleTextLayout extends StatelessWidget {
  const SimpleTextLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            18.height,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),

                    /// For setting up all available width.
                    const SizedBox(
                      width: double.infinity,
                    ),
                    ParentDistance(
                      color: Colors.deepOrange,
                      skipParent: 2,
                      child: Text(
                        'Hello there',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    16.height,
                    const ParentDistance(
                      skipParent: 2,
                      child: Text(
                        'Hey this is fake, randomly generated data, no no it is fake written data. Whatever it is but it works',
                      ),
                    ),
                    20.height,
                    ParentDistance(
                      color: Colors.green,
                      skipParent: 2,
                      child: CupertinoButton.filled(
                        child: const Text('Tap me'),
                        onPressed: () {},
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: movableItems,
        ),
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
  const MoveableStackItem({super.key});

  @override
  State<MoveableStackItem> createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;

  @override
  void initState() {
    super.initState();
  }

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
          color: Colors.redAccent,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
