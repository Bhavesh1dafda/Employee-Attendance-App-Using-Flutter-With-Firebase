import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final double size;
  final String? semanticLabel;

  AssetIcon(
    this.path, {
    this.color,
    this.size = 24,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(path),
      color: color,
      size: size,
      semanticLabel: semanticLabel,
    );
  }
}
