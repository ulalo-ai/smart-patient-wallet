import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class VerticalDottedLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final BoxDecoration decoration;

  const VerticalDottedLine({
    Key? key,
    this.height = 200.0,
    this.dashWidth = 2.0,
    this.dashHeight = 8.0,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxHeight = constraints.constrainHeight();
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: decoration,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}