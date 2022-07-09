import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  const CardWithImage(
      {Key? key,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);
  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
