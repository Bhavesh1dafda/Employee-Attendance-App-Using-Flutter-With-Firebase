import 'package:flutter/material.dart';

import 'imageView.dart';

class CircleImage extends StatelessWidget {
  final String? path;
  final ImageType? imageType;
  final BoxFit fit;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ImageProvider? backgroundImage;
  final String? placeHolderImagePath;

  CircleImage({
    @required this.path,
    @required this.imageType,
    this.fit = BoxFit.cover,
    this.radius = 50.0,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundImage,
    this.placeHolderImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      foregroundColor: foregroundColor,
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: ImageView(
          path!,
          imageType!,
          height: radius * 2,
          width: radius * 2,
          fit: fit,
          placeHolderImagePath: placeHolderImagePath!,
        ),
      ),
      radius: radius,
    );
  }
}
