import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ImageProvider? backgroundImage;

  CircleWidget({
    required this.child,
    this.alignment = Alignment.center,
    this.margin,
    this.padding,
    this.radius = 50.0,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      foregroundColor: foregroundColor,
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          alignment: alignment,
          padding: padding,
          margin: margin,
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      ),
      radius: radius,
    );
  }
}
